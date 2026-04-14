class Lumen < Formula
  desc "macOS log reviewer with color rendering and large file support"
  homepage "https://github.com/emersonding/lumen-log-viewer"
  url "https://github.com/emersonding/lumen-log-viewer/archive/refs/tags/v2.0.0.tar.gz"
  sha256 "f6b3de1df5fcfa72267a6a389042290bdf32024be3f300c9bf4a8d0eff7b7f46"
  license "MIT"

  depends_on :macos
  depends_on macos: :sonoma

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"

    # Create .app bundle
    app_dir = prefix/"Lumen.app/Contents"
    (app_dir/"MacOS").install ".build/release/Lumen"
    app_dir.install "Info.plist"
    if File.exist?("Sources/Resources/AppIcon.icns")
      (app_dir/"Resources").mkpath
      (app_dir/"Resources").install "Sources/Resources/AppIcon.icns"
    end

    # Also install the bare binary for CLI usage
    bin.install ".build/release/Lumen" => "lumen"
  end

  def post_install
    system "codesign", "--force", "--deep", "--sign", "-", prefix/"Lumen.app"
  end

  def caveats
    <<~EOS
      Lumen.app is installed at:
        #{prefix}/Lumen.app

      To add to Applications:
        ln -sf #{prefix}/Lumen.app /Applications/Lumen.app
    EOS
  end

  test do
    assert_predicate bin/"lumen", :exist?
  end
end
