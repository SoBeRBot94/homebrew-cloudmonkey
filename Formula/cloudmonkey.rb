class Cloudmonkey < Formula
  desc "CLI for Apache CloudStack"
  homepage "https://github.com/apache/cloudstack-cloudmonkey"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/apache/cloudstack-cloudmonkey/releases/download/6.5.0/cmk.darwin.arm64"
      sha256 "056a03bbed99050aceab5fe32489c9ec4bcb143c6accebfb49f3ec34bd974998"
    end
    on_intel do
      url "https://github.com/apache/cloudstack-cloudmonkey/releases/download/6.5.0/cmk.darwin.x86-64"
      sha256 "11cb907ec7331e95169c8d75c3e3f70c92268f9b42036ce1df435791ddeb3847"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/apache/cloudstack-cloudmonkey/releases/download/6.5.0/cmk.linux.arm64"
      sha256 "7885515c33630e45d94ade05847fd0110a9972b7f2650799d12f23432cee7cef"
    end
    on_intel do
      url "https://github.com/apache/cloudstack-cloudmonkey/releases/download/6.5.0/cmk.linux.x86-64"
      sha256 "0861cb684acce4b92caea65a9d2b048a96d3599b05e7772c87743884bf1c706c"
    end
  end

  def install
    cpu = if OS.mac?
            Hardware::CPU.arm? ? "darwin.arm64" : "darwin.x86-64"
          elsif Hardware::CPU.arm?
            "linux.arm64"
          else
            "linux.x86-64"
          end
    bin.install "cmk.#{cpu}" => "cmk"
  end

  test do
    assert_match "CloudMonkey", shell_output("#{bin}/cmk -v")
  end
end
