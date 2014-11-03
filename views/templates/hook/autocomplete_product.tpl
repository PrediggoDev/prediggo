{*
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
*  @author PrestaShop SA <contact@prestashop.com>
*  @copyright  2007-2014 PrestaShop SA
*  @version  Release: $Revision: 6594 $
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}

<a href="{$aRecommendation.link}" alt="{$aRecommendation.name|escape:'htmlall':'UTF-8'}" title="{$aRecommendation.name|escape:'htmlall':'UTF-8'}">
	<img src="{$link->getImageLink($aRecommendation.link_rewrite, $aRecommendation.id_image, $sImageType)}" alt="{$aRecommendation.name|escape:'htmlall':'UTF-8'}" title="{$aRecommendation.name|escape:'htmlall':'UTF-8'}" />
</a>
<h5 class="clear">
	<a href="{$aRecommendation.link}" alt="{$aRecommendation.name|escape:'htmlall':'UTF-8'}" title="{$aRecommendation.name|escape:'htmlall':'UTF-8'}">
		{$aRecommendation.name|escape:'htmlall':'UTF-8'}
	</a>
</h5>
<div class="price_container">
	{if $aRecommendation.specific_prices}
		{assign var='specific_prices' value=$aRecommendation.specific_prices}
		{if $specific_prices.reduction_type == 'percentage' && ($specific_prices.from == $specific_prices.to OR ($smarty.now|date_format:'%Y-%m-%d %H:%M:%S' <= $specific_prices.to && $smarty.now|date_format:'%Y-%m-%d %H:%M:%S' >= $specific_prices.from))}
 			<span class="reduction">(-{$specific_prices.reduction*100|floatval}%)</span>
		{/if}
	{/if}
	<span class="price">{if !$priceDisplay}{displayWtPrice p=$aRecommendation.price}{else}{displayWtPrice p=$aRecommendation.price_tax_exc}{/if}</span>
</div>