RubyChina招聘信息汇总
========================

定时同步并汇总RubyChina的招聘信息，提供搜索功能，解决RubyChina网站因使用了Google而搜索不了内容的问题。

## 使用方法

    git clone https://github.com/lingzhuzi/ruby_china_jobs.git
    cd ruby_china_jobs
    bundle install
    rake db:migrate
    rake job:download
    rails s
