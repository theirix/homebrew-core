require "language/node"

class NetlifyCli < Formula
  desc "Netlify command-line tool"
  homepage "https://www.netlify.com/docs/cli"
  url "https://registry.npmjs.org/netlify-cli/-/netlify-cli-3.7.1.tgz"
  sha256 "f38c0f9b34a926fed4d93f431aa1e2ac8dedb25e48b901e380b73652ec317b1d"
  license "MIT"
  head "https://github.com/netlify/cli.git"

  bottle do
    sha256 cellar: :any_skip_relocation, big_sur:  "6c3909b70f0a1bd112ee0f881cc593e673015861af3ad55e764a00be7ea1a1ba"
    sha256 cellar: :any_skip_relocation, catalina: "3fc17b93831a45210dfe03210f652e7efff34eb592946df4bdeb3fd1cb55da9b"
    sha256 cellar: :any_skip_relocation, mojave:   "9810855dfc456d01dedca08c18e113fd7f7f9144f25613a75bbb510424e3fbc2"
  end

  depends_on "node"

  uses_from_macos "expect" => :test

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    (testpath/"test.exp").write <<~EOS
      spawn #{bin}/netlify login
      expect "Opening"
    EOS
    assert_match "Logging in", shell_output("expect -f test.exp")
  end
end
