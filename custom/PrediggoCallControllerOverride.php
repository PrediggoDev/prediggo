<?php

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

require_once(_PS_MODULE_DIR_.'prediggo/classes/PrediggoConfig.php');
require_once(_PS_MODULE_DIR_.'prediggo/classes/PrediggoCall.php');

class PrediggoCallControllerOverride extends PrediggoCallController
{

	/**
	* overide the setPageName 
	* used in the category and manufacturer page
	*/
	public function setPageName()
	{
        $context = $this->oPrediggoConfig->getContext();
        $controller = $context->controller->php_self;
        $this->sPageName = $controller;
		//echo 'controller:'.$this->sPageName;
        return true;
    }

	
    /**
     * Set the current page name and store it to the object var $sPageName
     * You must update this function base on your URL rewrite policy
     * The page name is then used to select which type of recommendation bloc to use (GetItemReco,...)
     */
    /**
	public function setPageName2()
    {
		$context = $this->oPrediggoConfig->getContext();
        $controller = $context->controller->php_self;
        
        $pos = strpos($_SERVER['REQUEST_URI'],'controller=category');
       
        if ($pos==true || $pos>=1)
        {
			$this->sPageName =$this->oPrediggoConfig->categoryPageName;
            return true;
        }
		$pos = strpos($_SERVER['REQUEST_URI'],'controller=manufacturer');
		if ($pos==true || $pos>=1)
        {
			$this->sPageName =$this->oPrediggoConfig->manufacturerPageName;
            return true;
        }
        $pos = strpos($_SERVER['REQUEST_URI'],'controller=product');
        if ($pos==true || $pos>=1)
        {
            $this->sPageName ='product';
            return true;
        }
        $pos = strpos($_SERVER['REQUEST_URI'],'controller=order');
        if ($pos==true || $pos>=1)
        {
            $this->sPageName ='order';
            return true;
        }
        $this->sPageName = basename(preg_replace('/\.php$/', '', $_SERVER['PHP_SELF']));
        if (preg_match('#^'.__PS_BASE_URI__.'modules/([a-zA-Z0-9_-]+?)/(.*)$#', $_SERVER['REQUEST_URI'], $m))
            $this->sPageName = 'module-'.$m[1].'-'.str_replace(array('.php', '/'), array('', '-'), $m[2]);
    }
*/
    /**
     * Update the current $sPageName
     */
    public function _setPageName($sPageName)
    {
        $this->sPageName = $sPageName;
    }

    /**
     * You must update this function base on your module of pop-in cart if you have one
     */
    public function popInCart()
    {

    }

    public function variantId(){
       return 1;
    }
}