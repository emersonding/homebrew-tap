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
    bin.install ".build/release/Lumen" => "lumen"
  end

  def caveats
    <<~EOS
      Run the GUI log viewer from the terminal:
        lumen

      Or open a log file directly:
        lumen /path/to/file.log
    EOS
  end

  test do
    assert_predicate bin/"lumen", :exist?
  end
end
