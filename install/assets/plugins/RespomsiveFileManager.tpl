//<?php
/**
 * ResponSiveFileManager
 *
 *
 * @category    plugin
 * @version     9.12.0
 * @license     http://www.gnu.org/copyleft/gpl.html GNU Public License (GPL)
 * @package     modx
 * @internal    @events OnDocFormRender,OnRichTextEditorInit,OnUserFormRender,OnWUsrFormRender,OnModFormRender
 * @internal    @modx_category Manager and Admin
 * @internal    @properties
 * @internal    @installset base
 * @reportissues https://github.com/Grinyaha/ResponsiveFilemanager-for-Modx-Evo
 * @documentation https://github.com/Grinyaha/ResponsiveFilemanager-for-Modx-Evo/blob/master/README.md
 * @author      plugin author 64j
 * @author      ResponSiveFileManager author trippo (https://github.com/trippo/ResponsiveFilemanager)
 * @lastupdate  12/10/2017
 */

$e = &$modx->Event;
switch($e->name) {
case 'OnUserFormRender':
case 'OnWUsrFormRender':

if($modx->config['which_browser'] == 'filemanager') {

$output = '
<script>
    function BrowseServer() {
        var w = screen.width * 0.5;
        var h = screen.height * 0.5;
        document.userform.photo.id = "photo";
        OpenServerBrowser(\'' . MODX_MANAGER_URL . 'media/browser/' . $modx->config['which_browser'] . '/browser.php?Type=images&field_id=photo&popup=1&relative_url=1\', w, h);
    }
</script>
';

$e->output($output);
}

break;

case 'OnModFormRender':

if($modx->config['which_browser'] == 'filemanager') {

$output = '
<script>
    function BrowseServer() {
        var w = screen.width * 0.5;
        var h = screen.height * 0.5;
        document.mutate.icon.id = "icon";
        OpenServerBrowser(\'' . MODX_MANAGER_URL . 'media/browser/' . $modx->config['which_browser'] . '/browser.php?Type=images&field_id=icon&popup=1&relative_url=1\', w, h);
    }
</script>
';

$e->output($output);
}

break;

case 'OnDocFormRender':

if($modx->config['which_browser'] == 'filemanager') {

$output = '
<script>

    function OpenServerBrowser(url, width, height ) {
        var iLeft = (screen.width  - width) / 2 ;
        var iTop  = (screen.height - height) / 2 ;

        var sOptions = \'toolbar=no,status=no,resizable=yes,dependent=yes\' ;
        sOptions += \',width=\' + width ;
        sOptions += \',height=\' + height ;
        sOptions += \',left=\' + iLeft ;
        sOptions += \',top=\' + iTop ;

        var oWindow = window.open( url, \'FCKBrowseWindow\', sOptions ) ;
    }

    function BrowseServer(ctrl) {
        lastImageCtrl = ctrl;
        var w = screen.width * 0.5;
        var h = screen.height * 0.5;
        OpenServerBrowser(\'' . MODX_MANAGER_URL . 'media/browser/' . $modx->config['which_browser'] . '/browser.php?Type=images&field_id=\'+ctrl+\'&popup=1&relative_url=1\', w, h);
    }

    function BrowseFileServer(ctrl) {
        lastFileCtrl = ctrl;
        var w = screen.width * 0.5;
        var h = screen.height * 0.5;
        OpenServerBrowser(\'' . MODX_MANAGER_URL . 'media/browser/' . $modx->config['which_browser'] . '/browser.php?Type=files&field_id=\'+ctrl+\'&popup=1&relative_url=1\', w, h);
    }


    function BrowseServerRFM(ctrl) {
        lastImageCtrl = ctrl;
        var w = screen.width * 0.5;
        var h = screen.height * 0.5;
        OpenServerBrowser(\'' . MODX_MANAGER_URL . 'media/browser/' . $modx->config['which_browser'] . '/browser.php?Type=images&field_id=\'+ctrl+\'&popup=1&relative_url=1\', w, h);
    }

    function BrowseFileServerRFM(ctrl) {
        lastFileCtrl = ctrl;
        var w = screen.width * 0.5;
        var h = screen.height * 0.5;
        OpenServerBrowser(\'' . MODX_MANAGER_URL . 'media/browser/' . $modx->config['which_browser'] . '/browser.php?Type=files&field_id=\'+ctrl+\'&popup=1&relative_url=1\', w, h);
    }

    function SetUrlChange(el) {
        if (\'createEvent\' in document) {
        var evt = document.createEvent(\'HTMLEvents\');
        evt.initEvent(\'change\', false, true);
        el.dispatchEvent(evt);
    } else {
        el.fireEvent(\'onchange\');
    }
    }

    function SetUrl(url, width, height, alt) {
        if(lastFileCtrl) {
            var c = document.getElementById(lastFileCtrl);
            if(c && c.value != url) {
                c.value = url;
                SetUrlChange(c);
            }
            lastFileCtrl = \'\';
        } else if(lastImageCtrl) {
            var c = document.getElementById(lastImageCtrl);
            if(c && c.value != url) {
                c.value = url;
                SetUrlChange(c);
            }
            lastImageCtrl = \'\';
        } else {
            return;
        }
    }

    function responsive_filemanager_callback (a) {
        var el = document.getElementById(a);
        if(el) {
            SetUrlChange(el)
        }
    }

</script>
';

$e->output($output);
}

break;

case 'OnRichTextEditorInit':

if($modx->config['which_browser'] == 'filemanager') {

$output = '
<script>
    if(typeof config_tinymce4_' . $modx->config['tinymce4_theme'] . ' === "object") {
        config_tinymce4_' . $modx->config['tinymce4_theme'] . '.file_browser_callback = function(field, url, type, win) {
            if (type == "image") {
                BrowseServerRFM(field);
            }
            if (type == "file" || type == "media") {
                BrowseFileServerRFM(field);
            }
            return false;
        };
    }
</script>
';

$e->output($output);
}

break;
}