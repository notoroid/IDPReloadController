Pod::Spec.new do |s|

  s.name         = "IDPReloadController"
  s.version      = "0.0.2"
  s.summary      = "IDPReloadController is a UI component to encourage scroll to the user. It provides the tap area for notifications and read to the user at the top of the screen when there is a new reading of the timeline.Also it offers function inconspicuous presence of UI while scrolling by conjunction with the screen scrolling."

  s.description  = <<-DESC
                    IDPReloadController is a UI component to encourage scroll to the user. It provides the tap area for notifications and read to the user at the top of the screen when there is a new reading of the timeline.Also it offers function inconspicuous presence of UI while scrolling by conjunction with the screen scrolling. - IDPReloadController はユーザーにスクロールを促すためのUI部品です。タイムラインの新規読み込みがあった場合にユーザーへの通知と読み込みのためのタップ領域を画面上部に提供します。画面スクロールと連動することでスクロール中にUIの存在を目立たなく機能も提供しています。
                   DESC

  s.homepage     = "https://github.com/notoroid/IDPReloadController"
  s.screenshots  = "https://raw.githubusercontent.com/notoroid/IDPReloadController/master/ScreenShot/ss01.png"


  s.license      = "MIT"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "notoroid" => "noto@irimasu.com" }
  s.social_media_url   = "http://twitter.com/notoroid"

  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/notoroid/IDPReloadController.git", :tag => "v0.0.2" }

  s.source_files  = "Lib/**/*.{h,m}"
  s.public_header_files = "Lib/**/*.h"

  s.requires_arc = true

end
