# Homebrew formula for seeed-zephyr CLI.
#
# This formula is a template. To use it:
#   1. Publish the package to PyPI
#   2. Update `url` to the PyPI sdist URL
#   3. Update `sha256` with: shasum -a 256 seeed_zephyr-<version>.tar.gz
#   4. Host this file in a Homebrew tap repository
#
# Users install via:
#   brew tap limengdu/seeed
#   brew install limengdu/seeed/seeed-zephyr

class SeeedZephyr < Formula
  include Language::Python::Virtualenv

  desc "CLI for Seeed Studio XIAO boards with Zephyr RTOS"
  homepage "https://github.com/Seeed-Projects/seeed-zephyr-base"
  url "https://files.pythonhosted.org/packages/3c/47/94be24054125d83391f44e3f6d53e52c01eb15e1d71b7858347034c4b683/seeed_zephyr-0.1.0.tar.gz"
  sha256 "9c1dd026543127271995166b3293a94833a05d42a5e9fd0fee6e0d7ab8785b1b"
  license "Apache-2.0"

  depends_on "python@3.12"

  def install
    virtualenv_install_with_resources
  end

  test do
    system bin / "seeed-zephyr", "list", "boards"
  end
end
