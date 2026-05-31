class Archivist < Formula
  desc "Workflow-first ADR manager compatible with adr-tools"
  homepage "https://github.com/ramtinJ95/archivist"
  url "https://github.com/ramtinJ95/archivist/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "3cc98c5ea2db0e218bd4b152ddd4357e5a0fc9b1c240fee5d70efca6adfe91c6"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(
      ldflags: "-s -w -X github.com/ramtinJ95/archivist/internal/cli.Version=v#{version}",
    ), "./cmd/archivist"
  end

  test do
    assert_match "archivist v#{version}", shell_output("#{bin}/archivist version")

    system bin/"archivist", "init"
    assert_path_exists testpath/"doc/adr/0001-record-architecture-decisions.md"
    assert_match "0001-record-architecture-decisions.md", shell_output("#{bin}/archivist list")
  end
end
