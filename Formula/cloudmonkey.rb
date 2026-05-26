class Cloudmonkey < Formula
  desc "CLI for Apache CloudStack"
  version "6.5.0"
  homepage "https://github.com/apache/cloudstack-cloudmonkey"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/apache/cloudstack-cloudmonkey/releases/download/#{version}/cmk.darwin.arm64"
      sha256 "056a03bbed99050aceab5fe32489c9ec4bcb143c6accebfb49f3ec34bd974998"
    end
    on_intel do
      url "https://github.com/apache/cloudstack-cloudmonkey/releases/download/#{version}/cmk.darwin.x86-64"
      sha256 "11cb907ec7331e95169c8d75c3e3f70c92268f9b42036ce1df435791ddeb3847"
    end
  end

  on_linux do
    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/apache/cloudstack-cloudmonkey/releases/download/#{version}/cmk.linux.arm64"
        sha256 "7885515c33630e45d94ade05847fd0110a9972b7f2650799d12f23432cee7cef"
      else
        url "https://github.com/apache/cloudstack-cloudmonkey/releases/download/#{version}/cmk.linux.arm32"
        sha256 "0ac271fe57a4c8e24d8e99b95e1ff1ab73918c492892da9905459d60b3df0738"
      end
    end
    on_intel do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/apache/cloudstack-cloudmonkey/releases/download/#{version}/cmk.linux.x86-64"
        sha256 "0861cb684acce4b92caea65a9d2b048a96d3599b05e7772c87743884bf1c706c"
      else
        url "https://github.com/apache/cloudstack-cloudmonkey/releases/download/#{version}/cmk.linux.x86"
        sha256 "73f3f4cf9f419c1fcd3266cf3f1ddeb7b9063de9b6688296fbdba3bb5896dab1"
      end
    end
  end

  def install
    cpu = if OS.mac?
            Hardware::CPU.arm? ? "darwin.arm64" : "darwin.x86-64"
          else
            if Hardware::CPU.arm?
              Hardware::CPU.is_64_bit? ? "linux.arm64" : "linux.arm32"
            else 
              Hardware::CPU.is_64_bit? ? "linux.x86-64" : "linux.x86"
            end
          end
    bin.install "cmk.#{cpu}" => "cmk"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/cmk -v")
  end
end
