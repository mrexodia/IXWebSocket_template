# IXWebSocket Template

Simple template for [IXWebSocket](https://github.com/machinezone/IXWebSocket) (websocket and http client/server library for C++). This is an example of how [CPM](https://github.com/TheLartians/CPM.cmake) can be used to manage dependencies in your CMake project. The example supports both TLS and ZLIB out of the box (and both are statically linked), without requiring you to install **any** packages on your system. It was tested on Windows, Linux and macOS.

See `CMakeLists.txt` for details, it is much simpler than you might expect.

## Building

```sh
mkdir build && cd build
cmake ..
cmake --build .
```

That's it!
