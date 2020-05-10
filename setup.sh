echo "Installing nodejs..."
sudo apt update
sudo apt install -y nodejs
sudo apt install -y npm
nodejs -v

echo "Installing rbenv..."
sudo apt update
sudo apt install -y autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm5 libgdbm-dev
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
source ~/.bashrc
type rbenv
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

echo "Installing ruby..."
rbenv install -l
rbenv install 2.5.1
rbenv global 2.5.1
ruby -v
echo "gem: --no-document" > ~/.gemrc
gem install bundler
gem env home
gem install rails -v 5.2.0
rbenv rehash
rails -v

echo "Installing SQLite3..."
sudo apt update
sudo apt install -y sqlite3 libsqlite3-dev
sqlite3 --version
