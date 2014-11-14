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
{if isset($products)}
	<!-- Products list -->
	<ul id="product_list" class="clear">
	{foreach from=$products item=product name=products}
		<li class="ajax_block_product {if $smarty.foreach.products.first}first_item{elseif $smarty.foreach.products.last}last_item{/if} {if $smarty.foreach.products.index % 2}alternate_item{else}item{/if} clearfix">
			<div class="left_block">
				{if isset($comparator_max_item) && $comparator_max_item}
					<p class="compare">
						<input type="checkbox" class="comparator" id="comparator_item_{$product.id_product}" value="comparator_item_{$product.id_product}" {if isset($compareProducts) && is_array($compareProducts) && in_array($product.id_product, $compareProducts)}checked="checked"{/if} /> 
						<label for="comparator_item_{$product.id_product|escape:'htmlall':'UTF-8'}">{l s='Select to compare' mod='prediggo'}</label>
					</p>
				{/if}
			</div>
			<div class="center_block">
				<a href="{$product.link|escape:'htmlall':'UTF-8'}" class="product_img_link" title="{$product.name|escape:'htmlall':'UTF-8'}">
					<img src="{$link->getImageLink($product.link_rewrite, $product.id_image, $sImageType)}" alt="{$product.legend|escape:'htmlall':'UTF-8'}" {if isset($homeSize)} width="{$homeSize.width}" height="{$homeSize.height}"{/if} />
					{if isset($product.new) && $product.new == 1}<span class="new">{l s='New' mod='prediggo'}</span>{/if}
				</a>
				<h3><a href="{$product.link|escape:'htmlall':'UTF-8'}" title="{$product.name|escape:'htmlall':'UTF-8'}">{$product.name|escape:'htmlall':'UTF-8'|truncate:35:'...'}</a></h3>
				<p class="product_desc"><a href="{$product.link|escape:'htmlall':'UTF-8'}" title="{$product.description_short|strip_tags:'UTF-8'|truncate:360:'...'}" >{$product.description_short|strip_tags:'UTF-8'|truncate:360:'...'}</a></p>
			</div>
			<div class="right_block">
				{if isset($product.on_sale) && $product.on_sale && isset($product.show_price) && $product.show_price && !$PS_CATALOG_MODE}<span class="on_sale">{l s='On sale!' mod='prediggo'}</span>
				{elseif isset($product.reduction) && $product.reduction && isset($product.show_price) && $product.show_price && !$PS_CATALOG_MODE}<span class="discount">{l s='Reduced price!' mod='prediggo'}</span>{/if}
				{if (!$PS_CATALOG_MODE AND ((isset($product.show_price) && $product.show_price) || (isset($product.available_for_order) && $product.available_for_order)))}
				<div class="content_price">
                    {if $product.price == 0}
                        {if isset($product.show_price) && $product.show_price && !isset($restricted_country_mode)}<span class="price" ">{if !$priceDisplay}{convertPrice price=$product.orderprice}{else}{convertPrice price=$product.price_tax_exc}{/if}</span><br />{/if}
                    {else}
                        {if isset($product.show_price) && $product.show_price && !isset($restricted_country_mode)}<span class="price" ">{if !$priceDisplay}{convertPrice price=$product.price}{else}{convertPrice price=$product.price_tax_exc}{/if}</span><br />{/if}
					{/if}
                    {if isset($product.available_for_order) && $product.available_for_order && !isset($restricted_country_mode)}<span class="availability">{if ($product.allow_oosp || $product.quantity > 0)}{l s='Available' mod='prediggo'}{elseif (isset($product.quantity_all_versions) && $product.quantity_all_versions > 0)}{l s='Product available with different options' mod='prediggo'}{else}{l s='Out of stock' mod='prediggo'}{/if}</span>{/if}
				</div>
                    {if isset($product.online_only) && $product.online_only}<span class="online_only">{l s='Online only!' mod='prediggo'}</span>{/if}
                {/if}
                {if ($product.id_product_attribute == 0 || (isset($add_prod_display) && ($add_prod_display == 1))) && $product.available_for_order && !isset($restricted_country_mode) && $product.minimal_quantity <= 1 && $product.customizable != 2 && !$PS_CATALOG_MODE}
                    {if ($product.quantity == 0)}
                        {if ($product.allow_oosp || $product.quantity_all_versions > 0)}
                            {if isset($static_token)}
                                <a class="button ajax_add_to_cart_button exclusive" rel="ajax_id_product_{$product.id_product|intval}" href="{$link->getPageLink('cart',false, NULL, "add&amp;id_product={$product.id_product|intval}&amp;token={$static_token}", true)}" title="{l s='Add to cart' mod='prediggo'}"><span></span>{l s='Add to cart' mod='prediggo'}</a>
                            {else}
                                <a class="button ajax_add_to_cart_button exclusive" rel="ajax_id_product_{$product.id_product|intval}" href="{$link->getPageLink('cart',false, NULL, "add&amp;id_product={$product.id_product|intval}", true)} title="{l s='Add to cart' mod='prediggo'}"><span></span>{l s='Add to cart' mod='prediggo'}</a>
                            {/if}
                        {else}
                            <span class="exclusive"><span></span>{l s='Add to cart' mod='prediggo'}</span><br />
                        {/if}
                    {else}
                        {if ($product.allow_oosp || $product.quantity > 0)}
                            {if isset($static_token)}
                                <a class="button ajax_add_to_cart_button exclusive" rel="ajax_id_product_{$product.id_product|intval}" href="{$link->getPageLink('cart',false, NULL, "add&amp;id_product={$product.id_product|intval}&amp;token={$static_token}", true)}" title="{l s='Add to cart' mod='prediggo'}"><span></span>{l s='Add to cart' mod='prediggo'}</a>
                            {else}
                                <a class="button ajax_add_to_cart_button exclusive" rel="ajax_id_product_{$product.id_product|intval}" href="{$link->getPageLink('cart',false, NULL, "add&amp;id_product={$product.id_product|intval}", true)} title="{l s='Add to cart' mod='prediggo'}"><span></span>{l s='Add to cart' mod='prediggo'}</a>
                            {/if}
                        {else}
                            <span class="exclusive"><span></span>{l s='Add to cart' mod='prediggo'}</span><br />
                        {/if}
                    {/if}
                {/if}
				<a class="button lnk_view" href="{$product.link|escape:'htmlall':'UTF-8'}" title="{l s='View' mod='prediggo'}">{l s='View' mod='prediggo'}</a>
			</div>
		</li>
	{/foreach}
	</ul>
	<!-- /Products list -->
{/if}