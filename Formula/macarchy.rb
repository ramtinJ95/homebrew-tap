class Macarchy < Formula
  desc "Theme-driven macOS environment"
  homepage "https://github.com/ramtinJ95/macarchy"
  url "https://github.com/ramtinJ95/macarchy/releases/download/v0.9.10/macarchy-0.9.10-arm64-apple-darwin.tar.gz"
  sha256 "e1b1ffe8b98a4a8132b4ecbd26a74dd6eed80c4ce8719ab3d7576325f8e4b935"
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
