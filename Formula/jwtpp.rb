class Jwtpp < Formula
  desc "JSON Object Signing and Encryption library for C++"
  homepage "https://github.com/troian/jwtpp"
  url "https://github.com/troian/jwtpp/archive/v2.0.2.tar.gz"
  sha256 "c12961fdb3bf34780d9e61fcef97088a2b200edd507aacefd195a9b768f54e04"
  head "https://github.com/troian/jwtpp.git"

  bottle do
    cellar :any
  end

  depends_on "cmake" => :build
  depends_on "jsoncpp"
  depends_on "openssl"
  depends_on "pkg-config"

  resource "gtest" do
    url "https://github.com/google/googletest/archive/release-1.10.0.tar.gz"
    sha256 "9dc9157a9a1551ec7a7e43daea9a694a0bb5fb8bec81235d8a1e6ef64c716dcb"
  end

  def install
    ENV.cxx11

    (buildpath/"gtest").install resource("gtest")

    mkdir "build" do
      system "cmake", "..",
             "-DJWTPP_WITH_TESTS=ON",
             "-DJWTPP_WITH_SHARED_LIBS=ON",
             "-DCMAKE_MACOSX_RPATH=1",
             "-DOPENSSL_ROOT_DIR=#{Formula["openssl"].opt_prefix}",
             *std_cmake_args
      system "make"
      system "./jwtpp_test"
      system "make", "install"
    end
  end
end
