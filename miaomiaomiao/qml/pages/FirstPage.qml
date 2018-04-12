import QtQuick 2.0
import Sailfish.Silica 1.0
import Nemo.Configuration 1.0
import Nemo.Notifications 1.0
import xyz.birdzhang.ime.stt 1.0

Page{


    Timer {
        id: migrateTimer
        interval: 20000
        running: fasle
        repeat: false
        onTriggered: {
            if (recorder.state == Recorder.RecordingState) {
                recorder.stop();
                
            }
        }
    }
    Notification {
        function show(message) {
            replacesId = 0
            previewBody = message
            publish()
        }

        id: notification
        expireTimeout: 3000
    }

    Connections {
        target: recorder
        onPathCreationFailed: notification.show(qsTr("Couldn't create file in \"%0\"".arg(recorder.location)))
    }

    Connections {
        target: recorder
        onError: {
            switch (error) {
            case Recorder.ResourceError:
                notification.show(qsTr("Could not write to \"%0\"".arg(recorder.location)))
                break
            case Recorder.OutOfSpaceError:
                notification.show(qsTr("No space left on the device"))
                break
            default:
                break
            }
        }
    }

    ConfigurationGroup{
        id: config
        path: "/app/xyz.birdzhang.ime"
        property int pageSize: 20
        property int fetchSize: 15
    }
    
    Recorder{
        id: recorder

    }

    SilicaFlickable{
        anchors.fill: parent
        contentHeight: column.height
        Column{
            id: column
            width: parent.width
            spacing: Theme.paddingMedium
            PageHeader{
                title: "关于"
            }

            SectionHeader{
                text: "说明"
            }
            Label{
                text: "本程序大量参考木木大大的山寨谷歌输入法跟gexc大大的拼音输入法，后端采用谷歌拼音输入法代码，做到了既可以使用gexc大大的输入法键盘，又"+
                      "有木木大大输入法的词汇，并且无Xt9依赖可以安装在移植的机型上，特此声明。<br/>"
                       +"使用方式：到【设置】-【文本输入】中勾选【搜鸟输入法】，然后在输入的界面切换到本输入法即可，不需要重启。"
                       +"<br/>本程序只是测试一下开源的谷歌拼音输入法，并无其他意图，在旗鱼上更智能的输入法是不存在的~😂"
                wrapMode: Text.RichText
                font.pixelSize: Theme.fontSizeTiny
                color: Theme.primaryColor
                width: parent.width
                anchors{
                    left: parent.left
                    right: parent.right
                    rightMargin: Theme.paddingMedium
                    leftMargin: Theme.paddingMedium
                }

            }

            SectionHeader{
                text: "作者"
            }

            Label{
                text: "旗鱼俱乐部 @0312birdzhang 出品"
                wrapMode: Text.WordWrap
                textFormat: Text.RichText
                font.pixelSize: Theme.fontSizeTiny
                color: Theme.highlightColor
                width: parent.width - Theme.paddingLarge
                horizontalAlignment: Text.AlignRight
            }

            Item {
                width: parent.width
                height: Theme.paddingSmall
            }

            SectionHeader{
                text: "自定义"
            }

            SectionHeader{
                text: "联想词数量"
                font.pixelSize: Theme.fontSizeExtraSmall
            }
            Slider {
                minimumValue: 5
                maximumValue: 20
                stepSize: 1
                value: config.fetchSize
                width: parent.width
                valueText:  value
                onValueChanged: {
                    config.fetchSize = value;
                }
            }

            SectionHeader{
                text: "候选词数量"
                font.pixelSize: Theme.fontSizeExtraSmall
            }

            Slider {
                minimumValue: 10
                maximumValue: 25
                stepSize: 1
                value: config.pageSize
                width: parent.width
                valueText: value
                onValueChanged: {
                    config.pageSize = value;
                }
            }

            Image{
                source: "image://theme/"
                MouseArea{
                    anchors.fill: parent
                    onPressedAndHold:{
                        switch (recorder.state) {
                        case Recorder.StoppedState:
                            recorder.startRecording();

                            break
                        case Recorder.PausedState:
                            recorder.record()
                            break
                        default:
                            break
                        }
                    }
                }
            }
        }
    }
}
