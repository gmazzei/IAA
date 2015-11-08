# TP - Inteligencia Artificial Avanzada

### Pasos para instalar

1) Instalar Ruby con rbenv

<pre>
sudo apt-get update
sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev

cd
git clone git://github.com/sstephenson/rbenv.git .rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile

git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bash_profile
source ~/.bash_profile

rbenv install -v 2.2.1
rbenv global 2.2.1

echo "gem: --no-document" > ~/.gemrc
</pre>

<p>Fuente: <a href="https://www.digitalocean.com/community/tutorials/how-to-install-ruby-on-rails-with-rbenv-on-ubuntu-14-04">Acá</a></p>
<br/>

2) Instalar Bundler
<p>Administrador de dependencias.</p>
<pre>
gem install bundler
</pre>
<br/>


3) Instalar rmagick 
<p>Dependencia para tranformar imágenes.</p>
<pre>
sudo apt-get install imagemagick libmagickwand-dev
</pre>
<br/>


4) Instalar AI4R
<p>Biblioteca de IA</p>
<pre>
gem install ai4r
</pre>

<p>Fuente: <a href="https://github.com/SergioFierens/ai4r">Repositorio</a> y <a href="http://www.ai4r.org/">Página oficial</a>.</p>
<br>

--

###Ejecutar script
<pre>
ruby network_script.rb
</pre>
