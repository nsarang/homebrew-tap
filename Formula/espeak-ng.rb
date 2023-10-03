# typed: false
# frozen_string_literal: true

class EspeakNg < Formula
  desc "Multi-lingual software speech synthesizer"
  homepage "https://github.com/espeak-ng/espeak-ng"
  url "https://github.com/nsarang/espeak-ng/archive/refs/tags/1.52.tar.gz"
  sha256 "23cdbd2d64803763d73b6bf20bf679893367f925b59427ffec144964b006efcf"

  # bottle do
  #   root_url "https://github.com/danielbair/homebrew-tap/releases/download/bottles"
  #   rebuild 1
  #   sha256 yosemite: "5b7aa73d9fbb660d3aebf3e6d465d4fe949c0030454c2662007c6bc47c1cfde6"
  # end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "kramdown" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "ronn" => :build
  depends_on "nsarang/homebrew-tap/pcaudiolib"
  depends_on "nsarang/homebrew-tap/sonic-speech"

  def install
    system "./autogen.sh"
    system "./configure", "--prefix=#{prefix}", "--with-extdict-ru", "--with-extdict-zh", "--with-extdict-zhy"
    system "make", "-j1", "src/espeak-ng", "src/speak-ng", "en"
    system "make", "-j1", "install"
  end

  test do
    system "espeak-ng", "Testing.", "-w", "test.wav"
  end
end
