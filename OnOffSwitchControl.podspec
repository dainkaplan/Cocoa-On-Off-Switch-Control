Pod::Spec.new do |s|
  s.name         = "OnOffSwitchControl"
  s.version      = "0.0.1"
  s.summary      = "iOS-like switch toggle for Cocoa apps on OS X."
  s.homepage     = "https://bitbucket.org/dainkaplan/cocoa-on-off-switch-control"
  s.license      = { :type => 'BSD (3-clause)', :file => 'LICENSE.txt' }
  # Specify the authors of the library, with email addresses. You can often find
  # the email addresses of the authors by using the SCM log. E.g. $ git log
  #
  s.author       = { "Dain Kaplan" => "dain@tempura.org",
                     "Peter Hosey" => "hg@boredzo.org" }
  s.source       = { :hg  => 'ssh://hg@bitbucket.org/dainkaplan/cocoa-on-off-switch-control', :revision => 'tip' }
  s.platform     = :osx
  s.source_files = 'OnOffSwitchControl.{h,m}', 'OnOffSwitchControlCell.{h,m}'
  s.public_header_files = 'OnOffSwitchControl.h', 'OnOffSwitchControlCell.h'
  s.frameworks = 'Carbon'
end
