
Pod::Spec.new do |s|

s.name              = 'TopicEventBus'
s.version           = '0.0.1'
s.summary           = 'TopicEventBus'
s.homepage          = 'https://github.com/mcmatan/TopicEventBus'
s.ios.deployment_target = '8.0'
s.platform = :ios, '8.0'
s.license           = {
:type => 'MIT',
:file => 'LICENSE'
}
s.author            = {
'YOURNAME' => 'Matan'
}
s.source            = {
:git => 'https://github.com/mcmatan/TopicEventBus.git',
:tag => "#{s.version}" }

s.framework = "UIKit"
s.source_files      = 'TopicEventBus*' , 'Classes/*', 'Resource/*'
s.requires_arc      = true

end
