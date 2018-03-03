Pod::Spec.new do |s|

s.name = 'SwiftySKScrollView'
s.version = '2.1.1'
s.license = 'MIT'
s.summary = 'A swift helper to add a UIScrollView to your SpriteKit scenes.'

s.homepage = 'https://github.com/crashoverride777/swifty-sk-scroll-view'
s.social_media_url = 'http://twitter.com/overrideiactive'
s.authors = { 'Dominik' => 'overrideinteractive@icloud.com' }

s.requires_arc = true
s.ios.deployment_target = '9.3'
s.swift_version = '4'
    
s.source = {
    :git => 'https://github.com/crashoverride777/swifty-sk-scroll-view.git',
    :tag => s.version
}

s.source_files = "SwiftySKScrollView/**/*.{swift}"

end
