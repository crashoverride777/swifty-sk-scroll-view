Pod::Spec.new do |s|

s.name = 'SwiftySKScrollView'
s.version = '2.4.2'
s.license = 'MIT'
s.summary = 'A swift helper to add a UIScrollView to your SpriteKit scenes.'

s.homepage = 'https://github.com/crashoverride777/swifty-sk-scroll-view'
s.social_media_url = 'http://twitter.com/overrideiactive'
s.authors = { 'Dominik' => 'overrideinteractive@icloud.com' }

s.swift_version = '5.0'
s.requires_arc = true
s.ios.deployment_target = '10.3'
    
s.source = {
    :git => 'https://github.com/crashoverride777/swifty-sk-scroll-view.git',
    :tag => s.version
}

s.source_files = 'Sources/**/*.{swift}'

end
