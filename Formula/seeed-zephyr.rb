# Homebrew formula for the seeed-zephyr CLI.
#
# The CLI is a pure-Python package published to PyPI as a universal wheel, so
# this formula installs that wheel directly into an isolated virtualenv.
#
# On each CLI release, update `url` and `sha256` to the new wheel listed at:
#   https://pypi.org/pypi/seeed-zephyr/<version>/json
#
# Users install via:
#   brew tap limengdu/seeed
#   brew install limengdu/seeed/seeed-zephyr

class SeeedZephyr < Formula
  desc "CLI for Seeed Studio XIAO boards with Zephyr RTOS"
  homepage "https://github.com/limengdu/Seeed-Zephyr-Project"
  url "https://files.pythonhosted.org/packages/67/d6/252b00d3721b541c9c1bc73edd6ef7a1379feb4456ef275b0a975b1abd1a/seeed_zephyr-0.5.6-py3-none-any.whl", using: :nounzip
  sha256 "8a134ff102f2906d73c6b6ed38ecbbfc07a76aeed07b3be4f3e66fb44fa0572d"
  license "Apache-2.0"

  depends_on "python@3.12"

  def install
    # Build a standard virtualenv (with its own pip) and install the wheel into
    # it, then expose the CLI on the Homebrew prefix.
    system Formula["python@3.12"].opt_bin/"python3.12", "-m", "venv", libexec
    wheel = buildpath/"seeed_zephyr-#{version}-py3-none-any.whl"
    cp cached_download, wheel
    system libexec/"bin/python", "-m", "pip", "install", "--no-deps", wheel
    bin.install_symlink libexec/"bin/seeed-zephyr"
  end

  test do
    system bin/"seeed-zephyr", "list", "boards"
  end
end
