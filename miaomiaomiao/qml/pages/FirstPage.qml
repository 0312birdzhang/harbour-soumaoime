import QtQuick 2.0
import Sailfish.Silica 1.0

Page{

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
                      "有木木大大输入法的词汇，特此声明。<br/>"
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

//            TextField{
//                width: parent.width
//                focus: true
//            }
            Image{
                source: "./notexist.jpg"
                width: parent.width - Theme.paddingLarge
                height: width
                anchors.horizontalCenter: parent.horizontalCenter
                fillMode: Image.PreserveAspectFit
            }
        }
    }
}
