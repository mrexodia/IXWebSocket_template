#include <iostream>
#include <atomic>
#include <stdexcept>

#include <ixwebsocket/IXNetSystem.h>
#include <ixwebsocket/IXHttpClient.h>
#include <ixwebsocket/IXWebSocket.h>

#include <fmt/core.h>
#include <nlohmann/json.hpp>

using json = nlohmann::json;

struct pci_device
{
	std::string device_id;
	std::string description;
	std::string vendor_id;
	std::string vendor;
};

// partial specialization (full specialization works too)
namespace nlohmann
{
template<>
struct adl_serializer<pci_device>
{
	// Source: https://stackoverflow.com/a/217605/1806760
	// trim from start (in place)
	static void ltrim(std::string& s)
	{
		s.erase(s.begin(), std::find_if(s.begin(), s.end(), [](unsigned char ch) {
			return !std::isspace(ch);
		}));
	}

	static void to_json(json& j, const pci_device& d)
	{
		j = json
		{
			{ "id", d.device_id },
			{ "desc", d.description },
			{ "venID", d.vendor_id },
			{ "venDesc", d.vendor },
		};
	}

	static void from_json(const json& j, pci_device& d)
	{
		j.at("id").get_to(d.device_id);
		j.at("desc").get_to(d.description);
		j.at("venID").get_to(d.vendor_id);
		j.at("venDesc").get_to(d.vendor);

		// for some reason the server returns a space at the beginning for some fields, trim them
		ltrim(d.description);
		ltrim(d.vendor);
	}
};
}

std::vector<pci_device> query_device_information(const std::string& vendor_query, const std::string& device_query)
{
	ix::HttpClient httpClient;
	auto args = httpClient.createRequest();
	auto url = fmt::format("https://www.pcilookup.com/api.php?action=search&vendor={}&device={}", vendor_query, device_query);
	
	auto response = httpClient.get(url, args);
	if (response->errorCode != ix::HttpErrorCode::Ok)
		throw std::runtime_error(response->errorMsg);

	if (response->statusCode != 200)
		throw std::runtime_error(fmt::format("http error {}", response->statusCode));

	auto jbody = json::parse(response->body);
	return jbody.get<std::vector<pci_device>>();
}

int main()
{
	// Required on Windows
	ix::initNetSystem();

	try
	{
		auto devices = query_device_information("1630", "ff81");
		for (const auto& device : devices)
		{
			// Serialize to json + print
			json jdevice(device);
			fmt::print("{}", jdevice.dump(2));
		}
	}
	catch (std::exception& x)
	{
		fmt::print("Exception: {}", x.what());
	}
}
