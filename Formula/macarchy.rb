class Macarchy < Formula
  desc "Theme-driven macOS environment"
  homepage "https://github.com/ramtinJ95/macarchy"
  url "https://github.com/ramtinJ95/macarchy/releases/download/v0.4.1/macarchy-0.4.1-arm64-apple-darwin.tar.gz"
  sha256 "d83799e04a85346d1e0348cbffc8bc15458e90e1fc70217c852b7c44b656e207"
  license "MIT"

  depends_on arch: :arm64
  depends_on macos: :tahoe
  depends_on maximum_macos: :tahoe

  def install
    prefix.install "bin", "share"
  end

  test do
    assert_equal "#{version}\n", shell_output("#{bin}/macarchy --version")

    info = JSON.parse(shell_output("#{bin}/macarchy version --json"))
    assert_equal version.to_s, info.fetch("version")
    assert_equal "homebrew", info.fetch("installation")
    assert_equal "macos-arm64", info.fetch("platform")
    assert_match(/\A[0-9a-f]{40}\z/, info.fetch("revision"))

    assert_equal <<~EOS, shell_output("#{bin}/macarchy theme list")
      catppuccin-mocha\tdark\tCatppuccin Mocha
      kanagawa-wave\tdark\tKanagawa Wave
      tokyo-night\tdark\tTokyo Night
    EOS
  end
end
