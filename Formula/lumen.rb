class Lumen < Formula
  desc "macOS log reviewer with color rendering and large file support"
  homepage "https://github.com/emersonding/lumen-log-viewer"
  url "https://github.com/emersonding/lumen-log-viewer/releases/download/v2.0.0/lumen-2.0.0-arm64.tar.gz"
  sha256 "add881020baadf207c6131631751495e514c7b25fe1ab178b1bbcaeeb54ab4e6"
  license "MIT"
  version "2.0.0"

  depends_on :macos
  depends_on macos: :sonoma
  depends_on arch: :arm64

  def install
    bin.install "lumen"
    prefix.install "Lumen.app"
  end

  def post_install
    # Symlink to ~/Applications so it appears in Finder/Launchpad
    apps_dir = File.expand_path("~/Applications")
    FileUtils.mkdir_p(apps_dir)
    target = "#{apps_dir}/Lumen.app"
    FileUtils.rm_rf(target) if File.exist?(target)
    FileUtils.ln_sf("#{prefix}/Lumen.app", target)
  end

  def caveats
    <<~EOS
      Lumen.app has been linked to ~/Applications.

      On first launch, macOS Gatekeeper will block the app.
      Go to System Settings > Privacy & Security > click "Open Anyway".

      Or run from the terminal:
        lumen
        lumen /path/to/file.log
    EOS
  end

  test do
    assert_predicate bin/"lumen", :exist?
    assert_predicate prefix/"Lumen.app/Contents/MacOS/Lumen", :exist?
  end
end
