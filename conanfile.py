from conan import ConanFile
# from conan.tools.cmake import CMakeToolchain, CMakeDeps

class ThirdPartyConan(ConanFile):
    name = "third-party-conan"
    version = "1.0"
    settings = "os", "compiler", "build_type", "arch"
    # generators = "CMakeToolchain", "CMakeDeps"

    requires = [
        "boost/1.84.0",
        "catch2/3.5.2",
        "cryptopp/8.9.0",
        "libarchive/3.7.2",
        "libcurl/8.6.0",
        "libssh2/1.11.0",
        "libzip/1.10.1",
        "mbedtls/3.5.2",
        "openssl/3.2.1",
        "qt/6.6.1",
        "spdlog/1.13.0",
        "zlib/1.3.1"
    ]

    # def build(self):
    #     cmake = CMake(self)
    #     cmake.configure()
    #     cmake.build()