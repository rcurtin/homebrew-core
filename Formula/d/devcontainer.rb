class Devcontainer < Formula
  desc "Reference implementation for the Development Containers specification"
  homepage "https://containers.dev"
  url "https://registry.npmjs.org/@devcontainers/cli/-/cli-0.68.0.tgz"
  sha256 "bda4e89bf0c2d060870bc5082f1c7ba09cd7fda331620032e145bb938a880095"
  license "MIT"

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "0aa24a84e36726b9f575dcd248e8fb4e5f22130a0fdb2b996c856efb9da96b77"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "0aa24a84e36726b9f575dcd248e8fb4e5f22130a0fdb2b996c856efb9da96b77"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "0aa24a84e36726b9f575dcd248e8fb4e5f22130a0fdb2b996c856efb9da96b77"
    sha256 cellar: :any_skip_relocation, sonoma:         "5c119586215d89a3a1f09b4f98345e53716d254f74c89c4e56971f6b26f701f5"
    sha256 cellar: :any_skip_relocation, ventura:        "5c119586215d89a3a1f09b4f98345e53716d254f74c89c4e56971f6b26f701f5"
    sha256 cellar: :any_skip_relocation, monterey:       "5c119586215d89a3a1f09b4f98345e53716d254f74c89c4e56971f6b26f701f5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9136d4f9c0c69288c6a39abc420336b09a45e91cc4dd4ad1cc2159b77bf8978b"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    ENV["DOCKER_HOST"] = "/dev/null"
    # Modified .devcontainer/devcontainer.json from CLI example:
    # https://github.com/devcontainers/cli#try-out-the-cli
    (testpath/".devcontainer.json").write <<~EOS
      {
        "name": "devcontainer-homebrew-test",
        "image": "mcr.microsoft.com/devcontainers/rust:0-1-bullseye"
      }
    EOS
    output = shell_output("#{bin}/devcontainer up --workspace-folder .", 1)
    assert_match '{"outcome":"error","message":"', output
  end
end
