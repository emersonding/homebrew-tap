class KindleClip < Formula
  desc "CLI for browsing, searching, and exporting Kindle highlights"
  homepage "https://github.com/emersonding/kindle-clip-processor"
  url "https://github.com/emersonding/kindle-clip-processor/releases/download/v0.1.1/kindle-clip_0.1.1_darwin_arm64.tar.gz"
  sha256 "2638d4750df42c37363d3aa1d0d86acd120455020a175689279bdff4cf1c7a9c"
  license "MIT"
  version "0.1.1"

  depends_on :macos
  depends_on macos: :sonoma
  depends_on arch: :arm64

  def install
    bin.install "kindle-clip"
  end

  def caveats
    <<~EOS
      Run from the terminal:
        kindle-clip help

      Set your default Kindle clips location:
        kindle-clip set ~/Documents/Kindle

      List all books:
        kindle-clip list

      Search highlights:
        kindle-clip search <keyword>
    EOS
  end

  test do
    assert_predicate bin/"kindle-clip", :exist?
    assert_match "kindle-clip", shell_output("#{bin}/kindle-clip help")
  end
end
