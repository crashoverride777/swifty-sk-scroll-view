Pod::Spec.new do |s|

s.name = 'SwiftySKScrollView'
s.version = '2.5.0'
s.license = 'MIT'
s.summary = 'A Swift helper to add a UIScrollView to your SpriteKit scenes.'

s.homepage = 'https://github.com/crashoverride777/swifty-sk-scroll-view'
s.authors = { 'Dominik Ringler' => 'overrideinteractive@icloud.com' }

s.ios.deployment_target = '12.0'

s.requires_arc = true
s.swift_versions = ['5.3', '5.4', '5.5', '5.6']
    
s.source = {
    :git => 'https://github.com/crashoverride777/swifty-sk-scroll-view.git',
    :tag => s.version
}

s.source_files = 'Sources/**/*.{swift}'

end
