=begin
** Form generated from reading ui file 'mainwindow.ui'
**
** Created: niedz. lip 13 18:25:05 2014
**      by: Qt User Interface Compiler version 4.8.6
**
** WARNING! All changes made in this file will be lost when recompiling ui file!
=end

require 'Qt4'

class Ui_MainWindow
    attr_reader :centralwidget
    attr_reader :groupBox
    attr_reader :dial
    attr_reader :dial_2
    attr_reader :dial_3
    attr_reader :label
    attr_reader :label_2
    attr_reader :label_3
    attr_reader :doubleSpinBox
    attr_reader :doubleSpinBox_2
    attr_reader :doubleSpinBox_3
    attr_reader :line
    attr_reader :dial_4
    attr_reader :label_4
    attr_reader :doubleSpinBox_4
    attr_reader :line_7
    attr_reader :label_23
    attr_reader :dial_21
    attr_reader :doubleSpinBox_23
    attr_reader :groupBox_2
    attr_reader :dial_13
    attr_reader :label_13
    attr_reader :doubleSpinBox_15
    attr_reader :line_4
    attr_reader :dial_16
    attr_reader :label_16
    attr_reader :doubleSpinBox_16
    attr_reader :label_14
    attr_reader :label_15
    attr_reader :groupBox_3
    attr_reader :dial_15
    attr_reader :label_19
    attr_reader :doubleSpinBox_19
    attr_reader :dial_18
    attr_reader :label_20
    attr_reader :doubleSpinBox_20
    attr_reader :groupBox_4
    attr_reader :pushButton
    attr_reader :label_24
    attr_reader :groupBox_5
    attr_reader :label_25
    attr_reader :label_26
    attr_reader :label_27

    def setupUi(mainWindow)
    if mainWindow.objectName.nil?
        mainWindow.objectName = "mainWindow"
    end
    mainWindow.resize(800, 480)
    mainWindow.minimumSize = Qt::Size.new(800, 480)
    mainWindow.maximumSize = Qt::Size.new(800, 480)
    mainWindow.baseSize = Qt::Size.new(800, 480)
    @font = Qt::Font.new
    @font.family = "DINPro"
    mainWindow.font = @font
    mainWindow.locale = Qt::Locale.new(Qt::Locale::English, Qt::Locale::UnitedStates)
    @centralwidget = Qt::Widget.new(mainWindow)
    @centralwidget.objectName = "centralwidget"
    @font1 = Qt::Font.new
    @font1.family = "Lucida Grande"
    @centralwidget.font = @font1
    @groupBox = Qt::GroupBox.new(@centralwidget)
    @groupBox.objectName = "groupBox"
    @groupBox.geometry = Qt::Rect.new(590, 0, 201, 451)
    @font2 = Qt::Font.new
    @font2.family = "DINPro"
    @font2.kerning = true
    @groupBox.font = @font2
    @dial = Qt::Dial.new(@groupBox)
    @dial.objectName = "dial"
    @dial.geometry = Qt::Rect.new(10, 120, 71, 71)
    @dial.font = @font
    @dial.cursor = Qt::Cursor.new(Qt::ArrowCursor)
    @dial.minimum = -10000
    @dial.maximum = 10000
    @dial.notchTarget = 50
    @dial.notchesVisible = true
    @dial_2 = Qt::Dial.new(@groupBox)
    @dial_2.objectName = "dial_2"
    @dial_2.geometry = Qt::Rect.new(10, 200, 71, 71)
    @dial_2.font = @font
    @dial_2.cursor = Qt::Cursor.new(Qt::ArrowCursor)
    @dial_2.minimum = -10000
    @dial_2.maximum = 10000
    @dial_2.notchTarget = 50
    @dial_2.notchesVisible = true
    @dial_3 = Qt::Dial.new(@groupBox)
    @dial_3.objectName = "dial_3"
    @dial_3.geometry = Qt::Rect.new(10, 280, 71, 71)
    @dial_3.font = @font
    @dial_3.cursor = Qt::Cursor.new(Qt::ArrowCursor)
    @dial_3.minimum = -10000
    @dial_3.maximum = 10000
    @dial_3.orientation = Qt::Horizontal
    @dial_3.notchTarget = 50
    @dial_3.notchesVisible = true
    @label = Qt::Label.new(@groupBox)
    @label.objectName = "label"
    @label.geometry = Qt::Rect.new(90, 130, 81, 16)
    @label.font = @font
    @label_2 = Qt::Label.new(@groupBox)
    @label_2.objectName = "label_2"
    @label_2.geometry = Qt::Rect.new(90, 210, 81, 16)
    @label_2.font = @font
    @label_3 = Qt::Label.new(@groupBox)
    @label_3.objectName = "label_3"
    @label_3.geometry = Qt::Rect.new(90, 290, 81, 16)
    @label_3.font = @font
    @doubleSpinBox = Qt::DoubleSpinBox.new(@groupBox)
    @doubleSpinBox.objectName = "doubleSpinBox"
    @doubleSpinBox.geometry = Qt::Rect.new(90, 310, 91, 25)
    @doubleSpinBox.font = @font
    @doubleSpinBox.decimals = 3
    @doubleSpinBox.minimum = -10000
    @doubleSpinBox.maximum = 10000
    @doubleSpinBox.singleStep = 50
    @doubleSpinBox.value = 3
    @doubleSpinBox_2 = Qt::DoubleSpinBox.new(@groupBox)
    @doubleSpinBox_2.objectName = "doubleSpinBox_2"
    @doubleSpinBox_2.geometry = Qt::Rect.new(90, 230, 91, 25)
    @doubleSpinBox_2.font = @font
    @doubleSpinBox_2.decimals = 3
    @doubleSpinBox_2.minimum = -10000
    @doubleSpinBox_2.maximum = 10000
    @doubleSpinBox_2.singleStep = 50
    @doubleSpinBox_2.value = 200
    @doubleSpinBox_3 = Qt::DoubleSpinBox.new(@groupBox)
    @doubleSpinBox_3.objectName = "doubleSpinBox_3"
    @doubleSpinBox_3.geometry = Qt::Rect.new(90, 150, 91, 25)
    @doubleSpinBox_3.font = @font
    @doubleSpinBox_3.decimals = 3
    @doubleSpinBox_3.minimum = -10000
    @doubleSpinBox_3.maximum = 10000
    @doubleSpinBox_3.singleStep = 50
    @doubleSpinBox_3.value = 5500
    @line = Qt::Frame.new(@groupBox)
    @line.objectName = "line"
    @line.geometry = Qt::Rect.new(10, 350, 181, 20)
    @line.font = @font
    @line.setFrameShape(Qt::Frame::HLine)
    @line.setFrameShadow(Qt::Frame::Sunken)
    @dial_4 = Qt::Dial.new(@groupBox)
    @dial_4.objectName = "dial_4"
    @dial_4.geometry = Qt::Rect.new(10, 370, 71, 71)
    @dial_4.font = @font
    @dial_4.cursor = Qt::Cursor.new(Qt::ArrowCursor)
    @dial_4.maximum = 200
    @dial_4.invertedAppearance = false
    @dial_4.invertedControls = false
    @dial_4.wrapping = false
    @dial_4.notchTarget = 10
    @dial_4.notchesVisible = true
    @label_4 = Qt::Label.new(@groupBox)
    @label_4.objectName = "label_4"
    @label_4.geometry = Qt::Rect.new(90, 380, 91, 16)
    @label_4.font = @font
    @doubleSpinBox_4 = Qt::DoubleSpinBox.new(@groupBox)
    @doubleSpinBox_4.objectName = "doubleSpinBox_4"
    @doubleSpinBox_4.geometry = Qt::Rect.new(90, 400, 91, 25)
    @doubleSpinBox_4.font = @font
    @doubleSpinBox_4.decimals = 3
    @doubleSpinBox_4.maximum = 1
    @doubleSpinBox_4.value = 0.02
    @line_7 = Qt::Frame.new(@groupBox)
    @line_7.objectName = "line_7"
    @line_7.geometry = Qt::Rect.new(10, 100, 181, 20)
    @line_7.font = @font
    @line_7.setFrameShape(Qt::Frame::HLine)
    @line_7.setFrameShadow(Qt::Frame::Sunken)
    @label_23 = Qt::Label.new(@groupBox)
    @label_23.objectName = "label_23"
    @label_23.geometry = Qt::Rect.new(90, 40, 81, 16)
    @label_23.font = @font
    @dial_21 = Qt::Dial.new(@groupBox)
    @dial_21.objectName = "dial_21"
    @dial_21.geometry = Qt::Rect.new(10, 30, 71, 71)
    @dial_21.font = @font
    @dial_21.cursor = Qt::Cursor.new(Qt::ArrowCursor)
    @dial_21.minimum = 1
    @dial_21.maximum = 1000
    @dial_21.singleStep = 50
    @dial_21.pageStep = 200
    @dial_21.value = 20
    @dial_21.notchTarget = 1
    @dial_21.notchesVisible = true
    @doubleSpinBox_23 = Qt::DoubleSpinBox.new(@groupBox)
    @doubleSpinBox_23.objectName = "doubleSpinBox_23"
    @doubleSpinBox_23.geometry = Qt::Rect.new(90, 60, 91, 25)
    @doubleSpinBox_23.font = @font
    @doubleSpinBox_23.decimals = 3
    @doubleSpinBox_23.minimum = 0.001
    @doubleSpinBox_23.maximum = 1
    @doubleSpinBox_23.singleStep = 0.01
    @doubleSpinBox_23.value = 0.01
    @groupBox_2 = Qt::GroupBox.new(@centralwidget)
    @groupBox_2.objectName = "groupBox_2"
    @groupBox_2.geometry = Qt::Rect.new(330, 0, 201, 201)
    @groupBox_2.font = @font2
    @dial_13 = Qt::Dial.new(@groupBox_2)
    @dial_13.objectName = "dial_13"
    @dial_13.geometry = Qt::Rect.new(10, 30, 71, 71)
    @dial_13.font = @font
    @dial_13.cursor = Qt::Cursor.new(Qt::ArrowCursor)
    @dial_13.minimum = -180
    @dial_13.maximum = 180
    @dial_13.notchTarget = 30
    @dial_13.notchesVisible = true
    @label_13 = Qt::Label.new(@groupBox_2)
    @label_13.objectName = "label_13"
    @label_13.geometry = Qt::Rect.new(90, 40, 81, 16)
    @label_13.font = @font
    @doubleSpinBox_15 = Qt::DoubleSpinBox.new(@groupBox_2)
    @doubleSpinBox_15.objectName = "doubleSpinBox_15"
    @doubleSpinBox_15.geometry = Qt::Rect.new(90, 60, 91, 25)
    @doubleSpinBox_15.font = @font
    @doubleSpinBox_15.decimals = 3
    @doubleSpinBox_15.minimum = -90
    @doubleSpinBox_15.maximum = 90
    @doubleSpinBox_15.singleStep = 0.1
    @doubleSpinBox_15.value = 0
    @line_4 = Qt::Frame.new(@groupBox_2)
    @line_4.objectName = "line_4"
    @line_4.geometry = Qt::Rect.new(10, 100, 181, 20)
    @line_4.font = @font
    @line_4.setFrameShape(Qt::Frame::HLine)
    @line_4.setFrameShadow(Qt::Frame::Sunken)
    @dial_16 = Qt::Dial.new(@groupBox_2)
    @dial_16.objectName = "dial_16"
    @dial_16.geometry = Qt::Rect.new(10, 120, 71, 71)
    @dial_16.font = @font
    @dial_16.cursor = Qt::Cursor.new(Qt::ArrowCursor)
    @dial_16.maximum = 200
    @dial_16.invertedAppearance = false
    @dial_16.invertedControls = false
    @dial_16.wrapping = false
    @dial_16.notchTarget = 10
    @dial_16.notchesVisible = true
    @label_16 = Qt::Label.new(@groupBox_2)
    @label_16.objectName = "label_16"
    @label_16.geometry = Qt::Rect.new(90, 130, 91, 16)
    @label_16.font = @font
    @doubleSpinBox_16 = Qt::DoubleSpinBox.new(@groupBox_2)
    @doubleSpinBox_16.objectName = "doubleSpinBox_16"
    @doubleSpinBox_16.geometry = Qt::Rect.new(90, 150, 91, 25)
    @doubleSpinBox_16.font = @font
    @doubleSpinBox_16.decimals = 3
    @doubleSpinBox_16.maximum = 1
    @doubleSpinBox_16.value = 0.02
    @label_14 = Qt::Label.new(@centralwidget)
    @label_14.objectName = "label_14"
    @label_14.geometry = Qt::Rect.new(530, 90, 61, 31)
    @palette = Qt::Palette.new
    brush = Qt::Brush.new(Qt::Color.new(111, 111, 111, 255))
    brush.style = Qt::SolidPattern
    @palette.setBrush(Qt::Palette::Active, Qt::Palette::WindowText, brush)
    brush1 = Qt::Brush.new(Qt::Color.new(207, 207, 207, 255))
    brush1.style = Qt::SolidPattern
    @palette.setBrush(Qt::Palette::Active, Qt::Palette::Text, brush1)
    @palette.setBrush(Qt::Palette::Inactive, Qt::Palette::WindowText, brush)
    @palette.setBrush(Qt::Palette::Inactive, Qt::Palette::Text, brush1)
    brush2 = Qt::Brush.new(Qt::Color.new(69, 69, 69, 255))
    brush2.style = Qt::SolidPattern
    @palette.setBrush(Qt::Palette::Disabled, Qt::Palette::WindowText, brush2)
    @palette.setBrush(Qt::Palette::Disabled, Qt::Palette::Text, brush2)
    @label_14.palette = @palette
    @font3 = Qt::Font.new
    @font3.pointSize = 44
    @font3.bold = false
    @font3.weight = 50
    @label_14.font = @font3
    @label_14.alignment = Qt::AlignCenter
    @label_15 = Qt::Label.new(@centralwidget)
    @label_15.objectName = "label_15"
    @label_15.geometry = Qt::Rect.new(530, 350, 61, 31)
    @palette1 = Qt::Palette.new
    @palette1.setBrush(Qt::Palette::Active, Qt::Palette::WindowText, brush)
    @palette1.setBrush(Qt::Palette::Active, Qt::Palette::Text, brush1)
    @palette1.setBrush(Qt::Palette::Inactive, Qt::Palette::WindowText, brush)
    @palette1.setBrush(Qt::Palette::Inactive, Qt::Palette::Text, brush1)
    @palette1.setBrush(Qt::Palette::Disabled, Qt::Palette::WindowText, brush2)
    @palette1.setBrush(Qt::Palette::Disabled, Qt::Palette::Text, brush2)
    @label_15.palette = @palette1
    @label_15.font = @font3
    @label_15.alignment = Qt::AlignCenter
    @groupBox_3 = Qt::GroupBox.new(@centralwidget)
    @groupBox_3.objectName = "groupBox_3"
    @groupBox_3.geometry = Qt::Rect.new(330, 260, 201, 191)
    @groupBox_3.font = @font2
    @dial_15 = Qt::Dial.new(@groupBox_3)
    @dial_15.objectName = "dial_15"
    @dial_15.geometry = Qt::Rect.new(10, 30, 71, 71)
    @dial_15.font = @font
    @dial_15.cursor = Qt::Cursor.new(Qt::ArrowCursor)
    @dial_15.minimum = -180
    @dial_15.maximum = 180
    @dial_15.notchTarget = 30
    @dial_15.notchesVisible = true
    @label_19 = Qt::Label.new(@groupBox_3)
    @label_19.objectName = "label_19"
    @label_19.geometry = Qt::Rect.new(90, 40, 81, 16)
    @label_19.font = @font
    @doubleSpinBox_19 = Qt::DoubleSpinBox.new(@groupBox_3)
    @doubleSpinBox_19.objectName = "doubleSpinBox_19"
    @doubleSpinBox_19.geometry = Qt::Rect.new(90, 60, 91, 25)
    @doubleSpinBox_19.font = @font
    @doubleSpinBox_19.decimals = 3
    @doubleSpinBox_19.minimum = -90
    @doubleSpinBox_19.maximum = 90
    @doubleSpinBox_19.singleStep = 0.1
    @doubleSpinBox_19.value = 0
    @dial_18 = Qt::Dial.new(@groupBox_3)
    @dial_18.objectName = "dial_18"
    @dial_18.geometry = Qt::Rect.new(10, 110, 71, 71)
    @dial_18.font = @font
    @dial_18.cursor = Qt::Cursor.new(Qt::ArrowCursor)
    @dial_18.maximum = 200
    @dial_18.invertedAppearance = false
    @dial_18.invertedControls = false
    @dial_18.wrapping = false
    @dial_18.notchTarget = 10
    @dial_18.notchesVisible = true
    @label_20 = Qt::Label.new(@groupBox_3)
    @label_20.objectName = "label_20"
    @label_20.geometry = Qt::Rect.new(90, 120, 91, 16)
    @label_20.font = @font
    @doubleSpinBox_20 = Qt::DoubleSpinBox.new(@groupBox_3)
    @doubleSpinBox_20.objectName = "doubleSpinBox_20"
    @doubleSpinBox_20.geometry = Qt::Rect.new(90, 140, 91, 25)
    @doubleSpinBox_20.font = @font
    @doubleSpinBox_20.decimals = 3
    @doubleSpinBox_20.maximum = 1
    @doubleSpinBox_20.value = 0.02
    @groupBox_4 = Qt::GroupBox.new(@centralwidget)
    @groupBox_4.objectName = "groupBox_4"
    @groupBox_4.geometry = Qt::Rect.new(70, 0, 201, 201)
    @groupBox_4.font = @font2
    @pushButton = Qt::PushButton.new(@groupBox_4)
    @pushButton.objectName = "pushButton"
    @pushButton.geometry = Qt::Rect.new(10, 40, 181, 71)
    @font4 = Qt::Font.new
    @font4.family = "DINPro"
    @font4.pointSize = 24
    @font4.bold = false
    @font4.italic = false
    @font4.underline = false
    @font4.weight = 50
    @pushButton.font = @font4
    @pushButton.checkable = true
    @pushButton.checked = false
    @pushButton.autoExclusive = false
    @pushButton.autoDefault = false
    @label_24 = Qt::Label.new(@centralwidget)
    @label_24.objectName = "label_24"
    @label_24.geometry = Qt::Rect.new(270, 90, 61, 31)
    @palette2 = Qt::Palette.new
    @palette2.setBrush(Qt::Palette::Active, Qt::Palette::WindowText, brush)
    @palette2.setBrush(Qt::Palette::Active, Qt::Palette::Text, brush1)
    @palette2.setBrush(Qt::Palette::Inactive, Qt::Palette::WindowText, brush)
    @palette2.setBrush(Qt::Palette::Inactive, Qt::Palette::Text, brush1)
    @palette2.setBrush(Qt::Palette::Disabled, Qt::Palette::WindowText, brush2)
    @palette2.setBrush(Qt::Palette::Disabled, Qt::Palette::Text, brush2)
    @label_24.palette = @palette2
    @label_24.font = @font3
    @label_24.alignment = Qt::AlignCenter
    @groupBox_5 = Qt::GroupBox.new(@centralwidget)
    @groupBox_5.objectName = "groupBox_5"
    @groupBox_5.geometry = Qt::Rect.new(70, 260, 201, 191)
    @groupBox_5.font = @font2
    @label_25 = Qt::Label.new(@groupBox_5)
    @label_25.objectName = "label_25"
    @label_25.geometry = Qt::Rect.new(90, 130, 81, 16)
    @label_25.font = @font
    @label_26 = Qt::Label.new(@centralwidget)
    @label_26.objectName = "label_26"
    @label_26.geometry = Qt::Rect.new(270, 350, 61, 31)
    @palette3 = Qt::Palette.new
    @palette3.setBrush(Qt::Palette::Active, Qt::Palette::WindowText, brush)
    @palette3.setBrush(Qt::Palette::Active, Qt::Palette::Text, brush1)
    @palette3.setBrush(Qt::Palette::Inactive, Qt::Palette::WindowText, brush)
    @palette3.setBrush(Qt::Palette::Inactive, Qt::Palette::Text, brush1)
    @palette3.setBrush(Qt::Palette::Disabled, Qt::Palette::WindowText, brush2)
    @palette3.setBrush(Qt::Palette::Disabled, Qt::Palette::Text, brush2)
    @label_26.palette = @palette3
    @label_26.font = @font3
    @label_26.alignment = Qt::AlignCenter
    @label_27 = Qt::Label.new(@centralwidget)
    @label_27.objectName = "label_27"
    @label_27.geometry = Qt::Rect.new(140, 220, 61, 51)
    @palette4 = Qt::Palette.new
    @palette4.setBrush(Qt::Palette::Active, Qt::Palette::WindowText, brush)
    @palette4.setBrush(Qt::Palette::Active, Qt::Palette::Text, brush1)
    @palette4.setBrush(Qt::Palette::Inactive, Qt::Palette::WindowText, brush)
    @palette4.setBrush(Qt::Palette::Inactive, Qt::Palette::Text, brush1)
    @palette4.setBrush(Qt::Palette::Disabled, Qt::Palette::WindowText, brush2)
    @palette4.setBrush(Qt::Palette::Disabled, Qt::Palette::Text, brush2)
    @label_27.palette = @palette4
    @label_27.font = @font3
    @label_27.alignment = Qt::AlignCenter
    mainWindow.centralWidget = @centralwidget

    retranslateUi(mainWindow)

    Qt::MetaObject.connectSlotsByName(mainWindow)
    end # setupUi

    def setup_ui(mainWindow)
        setupUi(mainWindow)
    end

    def retranslateUi(mainWindow)
    mainWindow.windowTitle = Qt::Application.translate("MainWindow", "Balancer", nil, Qt::Application::UnicodeUTF8)
    @groupBox.title = Qt::Application.translate("MainWindow", "Controller", nil, Qt::Application::UnicodeUTF8)
    @label.text = Qt::Application.translate("MainWindow", "Proportional", nil, Qt::Application::UnicodeUTF8)
    @label_2.text = Qt::Application.translate("MainWindow", "Integral", nil, Qt::Application::UnicodeUTF8)
    @label_3.text = Qt::Application.translate("MainWindow", "Derivative", nil, Qt::Application::UnicodeUTF8)
    @label_4.text = Qt::Application.translate("MainWindow", "Low pass filter", nil, Qt::Application::UnicodeUTF8)
    @label_23.text = Qt::Application.translate("MainWindow", "Delay", nil, Qt::Application::UnicodeUTF8)
    @groupBox_2.title = Qt::Application.translate("MainWindow", "Motion", nil, Qt::Application::UnicodeUTF8)
    @label_13.text = Qt::Application.translate("MainWindow", "Target", nil, Qt::Application::UnicodeUTF8)
    @label_16.text = Qt::Application.translate("MainWindow", "Low pass filter", nil, Qt::Application::UnicodeUTF8)
    @label_14.text = Qt::Application.translate("MainWindow", "\342\206\222", nil, Qt::Application::UnicodeUTF8)
    @label_15.text = Qt::Application.translate("MainWindow", "\342\206\220", nil, Qt::Application::UnicodeUTF8)
    @groupBox_3.title = Qt::Application.translate("MainWindow", "Motors", nil, Qt::Application::UnicodeUTF8)
    @label_19.text = Qt::Application.translate("MainWindow", "Threshold", nil, Qt::Application::UnicodeUTF8)
    @label_20.text = Qt::Application.translate("MainWindow", "Boost", nil, Qt::Application::UnicodeUTF8)
    @groupBox_4.title = Qt::Application.translate("MainWindow", "Control", nil, Qt::Application::UnicodeUTF8)
    @pushButton.text = Qt::Application.translate("MainWindow", "Balance", nil, Qt::Application::UnicodeUTF8)
    @label_24.text = Qt::Application.translate("MainWindow", "\342\206\222", nil, Qt::Application::UnicodeUTF8)
    @groupBox_5.title = Qt::Application.translate("MainWindow", "Status", nil, Qt::Application::UnicodeUTF8)
    @label_25.text = Qt::Application.translate("MainWindow", "Lorem", nil, Qt::Application::UnicodeUTF8)
    @label_26.text = Qt::Application.translate("MainWindow", "\342\206\220", nil, Qt::Application::UnicodeUTF8)
    @label_27.text = Qt::Application.translate("MainWindow", "\342\206\221", nil, Qt::Application::UnicodeUTF8)
    end # retranslateUi

    def retranslate_ui(mainWindow)
        retranslateUi(mainWindow)
    end

end

module Ui
    class MainWindow < Ui_MainWindow
    end
end  # module Ui

if $0 == __FILE__
    a = Qt::Application.new(ARGV)
    u = Ui_MainWindow.new
    w = Qt::MainWindow.new
    u.setupUi(w)
    w.show
    a.exec
end
