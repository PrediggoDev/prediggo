/*
* 2007-2014 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
* @author PrestaShop SA <contact@prestashop.com>
* @copyright 2007-2014 PrestaShop SA
* @license http://opensource.org/licenses/afl-3.0.php Academic Free License (AFL 3.0)
* International Registered Trademark & Property of PrestaShop SA
*/

$(document).ready(function(){

    if($('form#_form').length)
        $('div#prediggo_configuration')
        .appendTo('form#_form');
    else if($('form#configuration_form').length)
        $('div#prediggo_configuration')
        .appendTo('form#configuration_form');


    // Prepare the tabs display
    $('div#fieldset_prediggo_presentation')
        .appendTo('div#prediggo_presentation');

    $('div#fieldset_main_conf, div#fieldset_server_conf_1, div#fieldset_client_import_export_configuration_2, div#fieldset_logs_configuration_3')
        .appendTo('div#main_conf');

    $('div#fieldset_export_conf_4, div#fieldset_attributes_selection_5, div#fieldset_black_list_reco_6, div#fieldset_black_list_search_7, div#fieldset_htaccess_conf_8')
        .appendTo('div#export_conf');

    $('div#fieldset_blocklayered_reco_conf_28')
        .appendTo('div#layered_reco_conf');

    $('div#fieldset_home_reco_conf_9, div#fieldset_home_1_reco_conf_10')
        .appendTo('div#home_reco_config');

    $('div#fieldset_allpage_0_conf_11, div#fieldset_allpage_1_conf_12, div#fieldset_allpage_2_conf_13')
        .appendTo('div#all_reco_config');

    $('div#fieldset_productpage_0_conf_14, div#fieldset_productpage_1_conf_15, div#fieldset_productpage_2_conf_16')
        .appendTo('div#prod_reco_config');

    $('div#fieldset_basket_0_reco_conf_17, div#fieldset_basket_1_reco_conf_18, div#fieldset_basket_2_reco_conf_19, div#fieldset_basket_3_reco_conf_20, div#fieldset_basket_4_reco_conf_21, div#fieldset_basket_5_reco_conf_22')
        .appendTo('div#bask_reco_config');

    $('div#fieldset_category_0_conf_23, div#fieldset_category_1_conf_24, div#fieldset_category_2_conf_25')
        .appendTo('div#cat_reco_config');

    $('div#fieldset_customer_0_conf_26, div#fieldset_customer_1_conf_27')
        .appendTo('div#cust_reco_config');

    $('div#fieldset_search_conf_29, div#fieldset_search_autocompletion_conf_30')
        .appendTo('div#search_conf');

    $('div#fieldset_search_autocompletion_conf_29')
        .appendTo('div#search_autocompletion_conf');

    // Init the tabs
    $('div#prediggo_configuration').tabs({
        'cache' : false
    });

    $('input[type="submit"]').bind('click', function(e){
        var sAction = $(this).parents('form').attr('action');
        $(this).parents('form').attr('action', sAction+'#'+$(this).parents('div.ui-tabs-panel').attr('id'));
    });

    // Init the autocompletion parts
    initAutoComplete('products_ids_not_recommendable');
    initAutoComplete('products_ids_not_searchable');
});

function initAutoComplete(elId)
{
    $('input[type="text"][name="'+elId+'"]').autocomplete('ajax_products_list.php', {
        minChars: 1,
        autoFill: true,
        max:20,
        matchContains: true,
        mustMatch:true,
        scroll:false,
        cacheLength:0,
        formatItem: function(item) {
            return item[1]+' - '+item[0];
        }
    })
    .result(function(event, data, formatted){
        addElement(elId, event, data, formatted)
    })
    .setOptions({
        extraParams: {
            excludeIds : getElementsIds(elId)
        }
    });

    $('ul#ul_'+elId+' .deleteElement').live('click', function(){
        console.log('ert');
        deleteElement($(this).attr('data'), elId);
        $(this).remove();
    });
}

function addElement(elSuffix, event, data, formatted)
{
    if (data == null)
        return false;

    var elUl = $('ul#ul_'+elSuffix);
    var elInput = $('input#input_'+elSuffix);

    $('<li/>')
    .attr('data', data[1])
    .addClass('deleteElement')
    .css('cursor', 'pointer')
    .html(data[0])
    .append($('<img/>')
    .attr('src', '../img/admin/delete.gif'))
    .appendTo(elUl);

    elInput.val(elInput.val()+data[1]+',');

    $(event.currentTarget)
    .val('')
    .setOptions({
        extraParams: {excludeIds : getElementsIds(elSuffix)}
    });
}

function getElementsIds(elSuffix)
{
    if ($('input#input_'+elSuffix).val() === undefined)
        return false;
    return $('input#input_'+elSuffix).val().replace(/\\-/g,',').replace(/\\,$/,'').replace(/\,$/,'');
}

function deleteElement(iIDElement, elSuffix)
{
    var elInput = $('input#input_'+elSuffix);
    elInput.val(elInput.val().replace(iIDElement+',',''));
}