// Based on: https://github.com/machinezone/IXWebSocket#hello-world (BSD-3-Clause License)

#include <ixwebsocket/IXNetSystem.h>
#include <ixwebsocket/IXWebSocket.h>
#include <iostream>
#include <atomic>

int main()
{
	// Required on Windows
	ix::initNetSystem();

	// Our websocket object
	ix::WebSocket webSocket;

	// TLS options
	ix::SocketTLSOptions tlsOptions;
#ifndef _WIN32
	// Currently system CAs are not supported on non-Windows platforms with mbedtls
	tlsOptions.caFile = "NONE";
#endif // _WIN32
	webSocket.setTLSOptions(tlsOptions);

	std::string url("wss://echo.websocket.org");
	webSocket.setUrl(url);

	std::cout << "Connecting to " << url << "..." << std::endl;

	// To synchrously wait for connection to be established, use an atomic boolean
	std::atomic_bool connectionReady;

	// Setup a callback to be fired (in a background thread, watch out for race conditions !)
	// when a message or an event (open, close, error) is received
	webSocket.setOnMessageCallback([&webSocket, &connectionReady](const ix::WebSocketMessagePtr& msg)
	{
		if (msg->type == ix::WebSocketMessageType::Message)
		{
			std::cout << "Received message: " << msg->str << std::endl;
			std::cout << "> " << std::flush;
		}
		else if (msg->type == ix::WebSocketMessageType::Open)
		{
			std::cout << "Connection established" << std::endl;
			connectionReady = true;
		}
		else if (msg->type == ix::WebSocketMessageType::Error)
		{
			std::cout << "Connection error: " << msg->errorInfo.reason << std::endl;
			connectionReady = true;
		}
	}
	);

	// Now that our callback is setup, we can start our background thread and receive messages
	webSocket.start();

	// Wait for the connection to be ready (either successfully or with an error)
	while (!connectionReady)
	{
		std::this_thread::sleep_for(std::chrono::milliseconds(100));
	}

	// Handle connection error/timeout
	if (webSocket.getReadyState() != ix::ReadyState::Open)
	{
		return EXIT_FAILURE;
	}

	// Send an initial message to the server (default to TEXT mode)
	webSocket.send("Hello from IXWebSocket!");

	// Allow the user to play around
	while (true)
	{
		std::string text;
		std::getline(std::cin, text);

		if (text.empty())
			break;

		webSocket.send(text);
	}

	return EXIT_SUCCESS;
}