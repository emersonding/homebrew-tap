class Lumen < Formula
  desc "macOS log reviewer with color rendering and large file support"
  homepage "https://github.com/emersonding/lumen-log-viewer"
  url "https://github.com/emersonding/lumen-log-viewer/releases/download/v2.2.0/lumen-2.2.0-arm64.tar.gz"
  sha256 "28f6a97bdbfb87f252885ca0a41d5e8dff9d0227b73362c3cf6714db214dd819"
  license "MIT"
  version "2.2.0"

  depends_on :macos
  depends_on macos: :sonoma
  depends_on arch: :arm64

  def install
    bin.install "lumen"
    prefix.install "Lumen.app"
  end

  def caveats
    <<~EOS
      To add Lumen to your Applications folder (Launchpad, Dock, Spotlight):
        sudo ln -sf #{prefix}/Lumen.app /Applications/Lumen.app

      Run from the terminal:
        lumen

      On first launch, macOS Gatekeeper may block the app.
      Go to System Settings > Privacy & Security > click "Open Anyway".
    EOS
  end

  test do
    assert_predicate bin/"lumen", :exist?
    assert_predicate prefix/"Lumen.app/Contents/MacOS/Lumen", :exist?
  end
end
