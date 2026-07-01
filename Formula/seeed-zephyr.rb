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
  url "https://files.pythonhosted.org/packages/56/45/166c0c3dd3b948f80b565016cd8ca88c7780eb4bceedf4641c81d5fd156d/seeed_zephyr-0.2.0-py3-none-any.whl", using: :nounzip
  sha256 "df3f3d15252ad7a0add5360b6598244c78ce36e86594b60cc3a14b47e0cc5dd4"
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
