Pod::Spec.new do |s|

s.name = 'SwiftySKScrollView'
s.version = '2.1.0'
s.license = 'MIT'
s.summary = 'A swift helper to add a UIScrollView to your SpriteKit scenes.'
s.homepage = 'https://github.com/crashoverride777/SwiftySKScrollView'
s.social_media_url = 'http://twitter.com/overrideiactive'
s.authors = { 'Dominik' => 'overrideinteractive@icloud.com' }

s.requires_arc = true
s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4' }

s.ios.deployment_target = '9.3'

s.source = {
    :git => 'https://github.com/crashoverride777/SwiftySKScrollView.git',
    :tag => '2.1.0'
}

s.source_files = "SwiftySKScrollView/**/*.{swift}"

end
