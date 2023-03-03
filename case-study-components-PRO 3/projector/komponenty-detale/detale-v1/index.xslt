<?xml version="1.0" encoding="UTF-8"?><iai:component><iai:componentsdata><cdata-start/>
	<iaixsl:variable name="selectForSizes">2</iaixsl:variable>
	<iaixsl:variable name="selectForVersions">8</iaixsl:variable>
	<iaixsl:variable name="disable_projectorv3_ajax">1</iaixsl:variable>

	<!-- DEFINICJA ZMIENNYCH JS -->
	<script class="ajaxLoad">
		<![CDATA[cena_raty = ]]><iaixsl:value-of select="page/projector/product/price/@value"/><![CDATA[;]]>
		<iaixsl:choose>
			<iaixsl:when test="basket/@login">
				<![CDATA[var client_login = 'true']]>
			</iaixsl:when>
			<iaixsl:otherwise>
				<![CDATA[var client_login = 'false']]>
			</iaixsl:otherwise>
		</iaixsl:choose>
		<![CDATA[var client_points = ']]><iaixsl:value-of select="/shop/basket/@client_points"/><![CDATA[';]]>
		<![CDATA[var points_used = ']]><iaixsl:value-of select="/shop/basket/@points_used"/><![CDATA[';]]>
		<![CDATA[var shop_currency = ']]><iaixsl:value-of select="/shop/currency/@name"/><![CDATA[';]]>
		<![CDATA[var product_data = {]]>
		<![CDATA["product_id": ']]><iaixsl:value-of select="/shop/page/projector/product/@id"/><![CDATA[',]]>
		<iaixsl:if test="/shop/page/projector/product/@for_points = 'true'">
			<![CDATA["for_points": ']]><iaixsl:value-of select="/shop/page/projector/product/@for_points"/><![CDATA[',]]>
		</iaixsl:if>
		<![CDATA["currency":"]]><iaixsl:value-of select="/shop/currency/@name"/><![CDATA[",]]>
		<![CDATA["product_type":"]]><iaixsl:value-of select="page/projector/product/@product_type"/><![CDATA[",]]>
		<![CDATA["unit":"]]><iaixsl:value-of disable-output-escaping="yes" select="page/projector/product/sizes/@unit"/><![CDATA[",]]>
		<![CDATA["unit_plural":"]]><iaixsl:value-of disable-output-escaping="yes" select="page/projector/product/sizes/@unit_plural"/><![CDATA[",]]>

		<![CDATA["unit_sellby":"]]><iaixsl:value-of select="page/projector/product/sizes/@unit_sellby"/><![CDATA[",]]>
		<![CDATA["unit_precision":"]]><iaixsl:value-of select="page/projector/product/sizes/@unit_precision"/><![CDATA[",]]>

		<![CDATA["base_price]]><![CDATA[":{]]>
		<iaixsl:for-each select="/shop/page/projector/product/sizes/prices/@*">
			<![CDATA["]]><iaixsl:value-of select="name()"/><![CDATA[":"]]><iaixsl:value-of select="."/><![CDATA["]]><![CDATA[,]]>
		</iaixsl:for-each>
		<iaixsl:for-each select="/shop/page/projector/product/price/@*">
			<![CDATA["]]><iaixsl:value-of select="name()"/><![CDATA[":"]]><iaixsl:value-of select="."/><![CDATA["]]><iaixsl:if test="position() != last()"><![CDATA[,]]></iaixsl:if>
		</iaixsl:for-each>
		<![CDATA[}]]><![CDATA[,]]>

		<![CDATA["order_quantity_range]]><![CDATA[":{]]>
		<iaixsl:for-each select="/shop/page/projector/product/order_quantity_range/*">
			<![CDATA["]]><iaixsl:value-of select="name()"/><![CDATA[":"]]><iaixsl:value-of select="."/><![CDATA["]]><iaixsl:if test="position() != last()"><![CDATA[,]]></iaixsl:if>
		</iaixsl:for-each>
		<![CDATA[}]]><![CDATA[,]]>

		<![CDATA["sizes]]><![CDATA[":{]]>
		<iaixsl:for-each select="/shop/page/projector/product/sizes/size">
		<![CDATA["]]><iaixsl:choose><iaixsl:when test="@type = 'onesize'"><![CDATA[uniw]]></iaixsl:when><iaixsl:otherwise><iaixsl:value-of select="@type"/></iaixsl:otherwise></iaixsl:choose><![CDATA[":]]>
		<![CDATA[{]]>
		<iaixsl:for-each select="@*">
			<![CDATA["]]><iaixsl:value-of select="name()"/><iaixsl:choose><iaixsl:when test="starts-with(name(), 'amount')"><![CDATA[":]]></iaixsl:when><iaixsl:otherwise><![CDATA[":"]]></iaixsl:otherwise></iaixsl:choose><iaixsl:choose><iaixsl:when test=". = 'onesize'"><![CDATA[uniw]]></iaixsl:when><iaixsl:otherwise><iaixsl:value-of select="."/></iaixsl:otherwise></iaixsl:choose><iaixsl:choose><iaixsl:when test="starts-with(name(), 'amount')"><![CDATA[,]]></iaixsl:when><iaixsl:otherwise><![CDATA[",]]></iaixsl:otherwise></iaixsl:choose>
		</iaixsl:for-each>
		<iaixsl:for-each select="/shop/page/projector/product/bundle_price">
			<![CDATA["]]><iaixsl:value-of select="name()"/><![CDATA[":{]]>
			<iaixsl:for-each select="@*">
			<![CDATA["]]><iaixsl:value-of select="name()"/><![CDATA[":"]]><iaixsl:value-of select="."/><![CDATA["]]><iaixsl:if test="position() != last()"><![CDATA[,]]></iaixsl:if>
			</iaixsl:for-each>
			<![CDATA[}]]><![CDATA[,]]>
		</iaixsl:for-each>
		<iaixsl:if test="price/rebateNumber">
			<![CDATA["rebateNumber":{]]>
			<iaixsl:if test="price/rebateNumber/rebate">
				<![CDATA["items":[]]>
					<iaixsl:for-each select="price/rebateNumber/rebate">
						<![CDATA[{]]>
						<iaixsl:for-each select="@*">
							<![CDATA["]]><iaixsl:value-of select="name()"/><![CDATA[":"]]><iaixsl:value-of select="."/><![CDATA["]]><iaixsl:if test="position() != last()"><![CDATA[,]]></iaixsl:if>
						</iaixsl:for-each>
						<![CDATA[}]]><iaixsl:if test="position() != last()"><![CDATA[,]]></iaixsl:if>
					</iaixsl:for-each>
				<![CDATA[]]]><![CDATA[,]]>
			</iaixsl:if>
			<iaixsl:for-each select="price/rebateNumber/@*">
				<![CDATA["]]><iaixsl:value-of select="name()"/><![CDATA[":"]]><iaixsl:value-of select="."/><![CDATA["]]><iaixsl:if test="position() != last()"><![CDATA[,]]></iaixsl:if>
			</iaixsl:for-each>
			<![CDATA[}]]><![CDATA[,]]>
		</iaixsl:if>
		<iaixsl:if test="availability/shipping_time">
			<![CDATA["shipping_time":{]]>
			<iaixsl:for-each select="availability/shipping_time ">
			<iaixsl:for-each select="@*">
				<![CDATA["]]><iaixsl:value-of select="name()"/><![CDATA[":"]]><iaixsl:value-of disable-output-escaping="yes" select="."/><![CDATA["]]><iaixsl:if test="position() != last()"><![CDATA[,]]></iaixsl:if>
			</iaixsl:for-each>
			</iaixsl:for-each>
			<![CDATA[}]]><![CDATA[,]]>
		</iaixsl:if>
		<iaixsl:if test="availability/delay_time">
			<![CDATA["delay_time":{]]>
			<iaixsl:for-each select="availability/delay_time">
			<iaixsl:for-each select="@*">
				<![CDATA["]]><iaixsl:value-of select="name()"/><![CDATA[":"]]><iaixsl:value-of disable-output-escaping="yes" select="."/><![CDATA["]]><iaixsl:if test="position() != last()"><![CDATA[,]]></iaixsl:if>
			</iaixsl:for-each>
			</iaixsl:for-each>
			<![CDATA[}]]><![CDATA[,]]>
		</iaixsl:if>

		<iaixsl:if test="$disable_projectorv3_ajax = '0'">
			<iaixsl:for-each select="node()[name() = 'availability']">
				<![CDATA["]]><iaixsl:value-of select="name()"/><![CDATA[":{]]>
				<iaixsl:for-each select="@*">
				<![CDATA["]]><iaixsl:value-of select="name()"/><![CDATA[":"]]><iaixsl:value-of select="."/><![CDATA["]]><iaixsl:if test="position() != last()"><![CDATA[,]]></iaixsl:if>
				</iaixsl:for-each>
				<![CDATA[}]]><![CDATA[,]]>
			</iaixsl:for-each>
		</iaixsl:if>

		<iaixsl:for-each select="node()[not(name() = 'availability')]">
			<![CDATA["]]><iaixsl:value-of select="name()"/><![CDATA[":{]]>
			<iaixsl:for-each select="@*">
			<![CDATA["]]><iaixsl:value-of select="name()"/><![CDATA[":"]]><iaixsl:value-of select="."/><![CDATA["]]><iaixsl:if test="position() != last()"><![CDATA[,]]></iaixsl:if>
			</iaixsl:for-each>
			<![CDATA[}]]><iaixsl:if test="position() != last()"><![CDATA[,]]></iaixsl:if>
		</iaixsl:for-each>
		<![CDATA[}]]><iaixsl:if test="position() != last()"><![CDATA[,]]></iaixsl:if>
		</iaixsl:for-each>
		<![CDATA[}]]>

		<![CDATA[}]]>
		<![CDATA[var  trust_level = ']]><iaixsl:value-of select="/shop/@trust_level"/><![CDATA[';]]>
	</script>
	<!-- KONIEC DEFINICJA ZMIENNYCH JS -->

	<form id="projector_form" class="projector_details" action="/basketchange.php" method="post">
		<iaixsl:if test="/shop/page/projector/product/price/@value = 0"><iaixsl:attribute name="class" ><![CDATA[projector_details --phone]]></iaixsl:attribute></iaixsl:if>
		<iaixsl:if test="count(/shop/page/projector/product/sizes/size[availability/@status = 'disable']) = count(/shop/page/projector/product/sizes/size)">
			<iaixsl:attribute name="data-sizes_disable"><![CDATA[true]]></iaixsl:attribute>
		</iaixsl:if>
		<iaixsl:if test="/shop/action/basketChange/@url">
			<iaixsl:attribute name="action"><iaixsl:value-of select="/shop/action/basketChange/@url"/></iaixsl:attribute>
		</iaixsl:if>
		<iaixsl:attribute name="data-product_id"><iaixsl:value-of select="/shop/page/projector/product/@id"/></iaixsl:attribute>
		<iaixsl:if test="/shop/page/projector/bundled/@collection = 'true'">
			<iaixsl:attribute name="data-collection"><![CDATA[true]]></iaixsl:attribute>
		</iaixsl:if>
		<iaixsl:attribute name="data-type"><iaixsl:value-of select="/shop/page/projector/product/@product_type"/></iaixsl:attribute>
		<iaixsl:if test="/shop/page/projector/product/@price_from_formula = 'true'">
			<iaixsl:attribute name="data-price_formula"><![CDATA[true]]></iaixsl:attribute>
		</iaixsl:if>
		<!-- SUBSKRYPCJA -->
		<iaixsl:if test="/shop/page/projector/product/subscriptions/subscription">
			<iaixsl:attribute name="data-subscription" ><iaixsl:choose><iaixsl:when test="not(/shop/page/projector/product/subscriptions/@only_subscription)"><![CDATA[true]]></iaixsl:when><iaixsl:otherwise><![CDATA[only]]></iaixsl:otherwise></iaixsl:choose></iaixsl:attribute>
		</iaixsl:if>
		<iaixsl:variable name="nettoPrice"><iaixsl:if test="/shop/page/@price_type = 'net'"><![CDATA[true]]></iaixsl:if></iaixsl:variable>

		<button style="display:none;" type="submit"/>
		<input id="projector_product_hidden" type="hidden" name="product"><iaixsl:attribute name="value"><iaixsl:value-of select="page/projector/product/@id"/></iaixsl:attribute></input>
		<input id="projector_size_hidden" type="hidden" name="size" autocomplete="off">
			<iaixsl:if test="/shop/page/projector/product/sizes/size/@type = 'onesize'">
				<iaixsl:attribute name="value"><iaixsl:value-of select="/shop/page/projector/product/sizes/size/@type"/></iaixsl:attribute>
			</iaixsl:if>
		</input>
		<input id="projector_mode_hidden" type="hidden" name="mode" value="1"/>
		<iaixsl:if test="/shop/page/projector/product/exchange/@exchange_id">
			<input id="projector_exchange_id_hidden" type="hidden" name="exchange_id">
			<iaixsl:attribute name="value"><iaixsl:value-of select="/shop/page/projector/product/exchange/@exchange_id"/></iaixsl:attribute>
			</input>
			<input id="projector_change_hidden" type="hidden" name="change" value="change"/>
		</iaixsl:if>

		<!-- SUBSKRYPCJA -->
		<iaixsl:if test="/shop/page/projector/product/subscriptions/subscription and /shop/page/projector/product/subscriptions/@only_subscription">
			<input type="hidden" name="subscription" value="1" id="projector_subscription_hidden"/>
		</iaixsl:if>

		<!-- SUBSKRYPCJA -->
		<iaixsl:variable name="firstDaysInPeriod" ><iaixsl:for-each select="/shop/page/projector/product/subscriptions/subscription"><iaixsl:sort select="@days_in_period" data-type="number"/><iaixsl:if test="position() = 1"><iaixsl:value-of select="@days_in_period" /></iaixsl:if></iaixsl:for-each></iaixsl:variable>
		<iaixsl:if test="/shop/page/projector/product/subscriptions/subscription">
			<input type="hidden" name="days_in_period" id="projector_subscription_days_hidden">
				<iaixsl:attribute name="value" ><iaixsl:value-of select="$firstDaysInPeriod" /></iaixsl:attribute>
			</input>
		</iaixsl:if>

    <!-- SUBSKRYPCJA - SUBSKRYPCJA | ZAKUP JEDNORAZOWY -->
		<iaixsl:if test="/shop/page/projector/product/subscriptions/subscription and not(/shop/page/projector/product/subscriptions/@only_subscription)">
			<div class="projector_details__purchase --subscription projector_purchase f-group --radio">
				<input type="radio" name="subscription" class="f-control" value="1" id="radioSubscriptionTrue" checked="checked"/>
				<label class="f-label" for="radioSubscriptionTrue">
					<strong class="projector_purchase__label"><iai:variable vid="Subskrypcja"/></strong>
					<iaixsl:if test="/shop/page/projector/product/subscriptions/subscription[rebate]">
						<span class="projector_purchase__yousave">
							<iaixsl:if test="/shop/page/projector/product/subscriptions/subscription[1]/rebate">
								<iaixsl:attribute name="class" ><![CDATA[projector_purchase__yousave --active]]></iaixsl:attribute>
							</iaixsl:if>
							<span class="projector_purchase__yousave_before">(<iai:variable vid="Zniżka"/> </span>
							<span class="projector_purchase__yousave_value"><iaixsl:value-of select="/shop/page/projector/product/subscriptions/subscription[rebate][1]/rebate/@value_formatted" /></span>
							<span class="projector_purchase__yousave_after"> <iai:variable vid="kupując w subskrypcji"/>)</span>
						</span>
					</iaixsl:if>
				</label>
			</div>

			<div class="projector_details__purchase --normal projector_purchase f-group --radio">
				<input type="radio" name="subscription" class="f-control" value="0" id="radioSubscriptionFalse"/>
				<label class="f-label" for="radioSubscriptionFalse">
					<strong class="projector_purchase__label"><iai:variable vid="Zakup jednorazowy"/></strong>
					<iaixsl:if test="not(/shop/page/projector/product/price/@value = 0)">
						<span class="projector_purchase__price_wrapper">
							<iaixsl:choose>
								<iaixsl:when test="/shop/page/projector/product/sizes/prices and /shop/page/projector/product/sizes/prices/@maxprice_formatted != /shop/page/projector/product/sizes/prices/@minprice_formatted">
									<span class="projector_purchase__price_before"><iai:variable vid="od"/></span>
									<span class="projector_purchase__price">
										<iaixsl:choose>
											<iaixsl:when test="not($nettoPrice = '')">
												<iaixsl:value-of select="/shop/page/projector/product/sizes/prices/@minprice_net_formatted"/>
											</iaixsl:when>
											<iaixsl:otherwise>
												<iaixsl:value-of select="/shop/page/projector/product/sizes/prices/@minprice_formatted"/>
											</iaixsl:otherwise>
										</iaixsl:choose>
									</span>
								</iaixsl:when>
								<iaixsl:otherwise>
									<span class="projector_purchase__price">
										<iaixsl:choose>
											<iaixsl:when test="not($nettoPrice = '')">
												<iaixsl:value-of select="page/projector/product/price/@price_net_formatted"/>
											</iaixsl:when>
											<iaixsl:otherwise>
												<iaixsl:value-of select="page/projector/product/price/@price_formatted"/>
											</iaixsl:otherwise>
										</iaixsl:choose>
									</span>
								</iaixsl:otherwise>
							</iaixsl:choose>
							<span class="projector_purchase__price_after">
								<span class="projector_purchase__price_vat">
									<span class="price_vat"><iaixsl:value-of select="$priceTypeText"/></span>
								</span>
								<span class="projector_purchase__price_unit_sep">
										/
								</span>
								<span class="projector_purchase__price_unit"><iaixsl:value-of select="/shop/page/projector/product/sizes/@unit"/></span>
							</span>
						</span>
					</iaixsl:if>
				</label>
			</div>
		</iaixsl:if>

		<div class="projector_details__wrapper">
			<!-- SUBSKRYPCJA -  RABAT PROGOWY -->
			<iaixsl:if test="/shop/page/projector/subscriptions_rebates/rebate[@renewals_number_from != '1'] and /shop/page/projector/product/subscriptions/subscription">
				<div class="projector_details__subscription_rebates projector_subscription_rebates">
					<iaixsl:variable name="subscriptionRebateValue"><iaixsl:value-of select="/shop/page/projector/subscriptions_rebates/rebate[@renewals_number_from != '1']/@value_formatted" /></iaixsl:variable>
					<iaixsl:variable name="subscriptionRebateRenewals"><iaixsl:value-of select="/shop/page/projector/subscriptions_rebates/rebate[@renewals_number_from != '1']/@renewals_number_from" /></iaixsl:variable>
					<iaixsl:variable name="subcriptionRebateText"><iai:variable vid="Od %s dostawy w ramach tej subskrypcji rabat wyniesie -%s"/></iaixsl:variable>
					<iaixsl:value-of select="php:function('sprintf', $subcriptionRebateText, $subscriptionRebateRenewals, $subscriptionRebateValue)"/>
				</div>
			</iaixsl:if>

			<!-- CENA -->
			<div id="projector_prices_wrapper" class="projector_details__prices projector_prices">
				<iaixsl:if test="/shop/page/projector/product/price/@value = 0 and /shop/page/projector/product/price/@points &gt; 0">
					<iaixsl:attribute name="class" ><![CDATA[projector_details__prices projector_prices --only-points]]></iaixsl:attribute>
				</iaixsl:if>
				<!-- Cena katalogowa -->
				<div class="projector_prices__srp_wrapper" id="projector_price_srp_wrapper">
					<iaixsl:if test="not(/shop/page/projector/product/price/@srp)">
						<iaixsl:attribute name="style"><![CDATA[display:none;]]></iaixsl:attribute>
					</iaixsl:if>
					<span class="projector_prices__srp_label"><iai:variable vid="Cena katalogowa"/></span>
					<strong class="projector_prices__srp" id="projector_price_srp">
						<iaixsl:choose>
							<iaixsl:when test="not($nettoPrice = '')">
								<iaixsl:value-of select="/shop/page/projector/product/price/@srp_net_formatted"/>
							</iaixsl:when>
							<iaixsl:otherwise>
								<iaixsl:value-of select="/shop/page/projector/product/price/@srp_formatted"/>
							</iaixsl:otherwise>
						</iaixsl:choose>
					</strong>
				</div>

				<!-- Cena -->
				<div class="projector_prices__price_wrapper">

					<!-- Cena sprzed promocji -->
					<div class="projector_prices__maxprice_wrapper" id="projector_price_maxprice_wrapper">
						<iaixsl:if test="(not(/shop/page/projector/product/bundle_price/@percent_diff) or not(/shop/page/projector/product/bundle_price/@percent_diff &gt; 0) or not(/shop/page/projector/product/bundle_price/@amount_diff_gross &gt; 0)) and not(/shop/page/projector/product/price/@maxprice_formatted)">
							<iaixsl:attribute name="style"><![CDATA[display:none;]]></iaixsl:attribute>
						</iaixsl:if>
						
						<!-- YOUSAVE -->
						<span class="projector_prices__percent" id="projector_price_yousave">
							<iaixsl:if test="(not(/shop/page/projector/product/bundle_price/@percent_diff) or not(/shop/page/projector/product/bundle_price/@percent_diff &gt; 0) or not(/shop/page/projector/product/bundle_price/@amount_diff_gross &gt; 0)) and (not(/shop/page/projector/product/price/@yousave_percent) or not(/shop/page/projector/product/price/@yousave_percent &gt; 0))">
								<iaixsl:attribute name="style"><![CDATA[display:none;]]></iaixsl:attribute>
							</iaixsl:if>
							<span class="projector_prices__percent_value">-
								<iaixsl:choose>
									<iaixsl:when test="/shop/page/projector/product/bundle_price/@percent_diff and /shop/page/projector/product/bundle_price/@percent_diff &gt; 0 and /shop/page/projector/product/bundle_price/@amount_diff_gross &gt; 0">
										<iaixsl:choose>
											<iaixsl:when test="not(/shop/page/projector/product/bundle_price/@percent_diff &gt; 1)">
												<iaixsl:value-of select="/shop/page/projector/product/bundle_price/@percent_diff"/>
											</iaixsl:when>
											<iaixsl:otherwise>
												<iaixsl:value-of select="substring-before(/shop/page/projector/product/bundle_price/@percent_diff, '.')"/>
											</iaixsl:otherwise>
										</iaixsl:choose>
									</iaixsl:when>
									<iaixsl:when test="/shop/page/projector/product/price/@yousave_percent">
										<iaixsl:value-of select="/shop/page/projector/product/price/@yousave_percent"/>
									</iaixsl:when>
								</iaixsl:choose>%
							</span>
						</span>
						
						<del class="projector_prices__maxprice" id="projector_price_maxprice">
							<iaixsl:choose>
								<iaixsl:when test="/shop/page/projector/product/bundle_price/@percent_diff and /shop/page/projector/product/bundle_price/@percent_diff &gt; 0 and /shop/page/projector/product/bundle_price/@amount_diff_gross &gt; 0">
									<iaixsl:choose>
										<iaixsl:when test="not($nettoPrice = '')">
											<iaixsl:value-of select="/shop/page/projector/product/bundle_price/@price_net_formatted"/>
										</iaixsl:when>
										<iaixsl:otherwise>
											<iaixsl:value-of select="/shop/page/projector/product/bundle_price/@price_gross_formatted"/>
										</iaixsl:otherwise>
									</iaixsl:choose>
								</iaixsl:when>
								<iaixsl:when test="/shop/page/projector/product/sizes/prices/@size_min_maxprice_formatted != /shop/page/projector/product/sizes/prices/@size_max_maxprice_formatted">
									<span>
										<iaixsl:choose>
											<iaixsl:when test="not($nettoPrice = '')">
												<iaixsl:value-of select="/shop/page/projector/product/sizes/prices/@size_min_maxprice_net_formatted"/>
											</iaixsl:when>
											<iaixsl:otherwise>
												<iaixsl:value-of select="/shop/page/projector/product/sizes/prices/@size_min_maxprice_formatted"/>
											</iaixsl:otherwise>
										</iaixsl:choose>
									</span>
										<b><![CDATA[ - ]]></b>
									<span>
										<iaixsl:choose>
											<iaixsl:when test="not($nettoPrice = '')">
												<iaixsl:value-of select="/shop/page/projector/product/sizes/prices/@size_max_maxprice_net_formatted"/>
											</iaixsl:when>
											<iaixsl:otherwise>
												<iaixsl:value-of select="/shop/page/projector/product/sizes/prices/@size_max_maxprice_formatted"/>
											</iaixsl:otherwise>
										</iaixsl:choose>
									</span>
								</iaixsl:when>
								<iaixsl:when test="page/projector/product/price/@maxprice_formatted">
									<iaixsl:choose>
										<iaixsl:when test="not($nettoPrice = '')">
											<iaixsl:value-of select="page/projector/product/price/@maxprice_net_formatted"/>
										</iaixsl:when>
										<iaixsl:otherwise>
											<iaixsl:value-of select="page/projector/product/price/@maxprice_formatted"/>
										</iaixsl:otherwise>
									</iaixsl:choose>
								</iaixsl:when>
							</iaixsl:choose>
						</del>
					</div>
					
					<!--Cena normalna-->
					<iaixsl:choose>
						<iaixsl:when test="/shop/page/projector/product/price/@value = 0">
							<strong class="projector_prices__price" id="projector_price_value">
								<iaixsl:if test="/shop/page/projector/product/price/@points &gt; 0">
									<iaixsl:attribute name="style"><![CDATA[display:none;]]></iaixsl:attribute>
								</iaixsl:if>
								<a class="projector_prices__contact" href="/contact-pol.html" target="_blank">
									<iaixsl:attribute name="href"><iaixsl:value-of select="/shop/contact/link/@url"/></iaixsl:attribute>
									<img>
										<iaixsl:attribute name="src"><iaixsl:value-of select="/shop/page/projector/product/sizes/size/availability/@status_gfx_tel"/></iaixsl:attribute>
										<iaixsl:attribute name="alt"><iaixsl:value-of select="/shop/page/projector/product/sizes/size/availability/@status_description_tel"/></iaixsl:attribute>
									</img>
									<span><iaixsl:value-of disable-output-escaping="yes" select="/shop/page/projector/product/sizes/size/availability/@status_description_tel"/></span>
								</a>
							</strong>
						</iaixsl:when>
						<iaixsl:otherwise>
							<strong class="projector_prices__price" id="projector_price_value">
								<iaixsl:choose>
									<iaixsl:when test="/shop/page/projector/product/sizes/prices and /shop/page/projector/product/sizes/prices/@maxprice_formatted != /shop/page/projector/product/sizes/prices/@minprice_formatted">
										<!-- SUBSKRYPCJA -->
										<iaixsl:variable name="minprice" ><iaixsl:value-of select="/shop/page/projector/product/sizes/prices/@minprice" /></iaixsl:variable>
										<iaixsl:variable name="maxprice" ><iaixsl:value-of select="/shop/page/projector/product/sizes/prices/@maxprice" /></iaixsl:variable>
										<span>
											<!-- SUBSKRYPCJA -->
											<iaixsl:attribute name="data-subscription-max" ><iaixsl:choose>
												<iaixsl:when test="/shop/page/projector/product/sizes/size/price[@value = $minprice]/@maxprice">
													<iaixsl:value-of select="/shop/page/projector/product/sizes/size/price[@value = $minprice]/@maxprice" />
												</iaixsl:when>
												<iaixsl:otherwise>
													<iaixsl:value-of select="$minprice" />
												</iaixsl:otherwise>
											</iaixsl:choose></iaixsl:attribute>
											<!-- SUBSKRYPCJA -->
											<iaixsl:attribute name="data-subscription-max-net" ><iaixsl:choose>
												<iaixsl:when test="/shop/page/projector/product/sizes/size/price[@value = $minprice]/@maxprice_net">
													<iaixsl:value-of select="/shop/page/projector/product/sizes/size/price[@value = $minprice]/@maxprice_net" />
												</iaixsl:when>
												<iaixsl:otherwise>
													<iaixsl:value-of select="/shop/page/projector/product/sizes/prices/@minprice_net" />
												</iaixsl:otherwise>
											</iaixsl:choose></iaixsl:attribute>
											<!-- SUBSKRYPCJA -->
											<iaixsl:attribute name="data-subscription-save" ><iaixsl:value-of select="/shop/page/projector/product/sizes/size/price[@value = $minprice]/@yousave" /></iaixsl:attribute>
											<!-- SUBSKRYPCJA -->
											<iaixsl:attribute name="data-subscription-before" ><iaixsl:choose>
												<iaixsl:when test="/shop/page/projector/product/sizes/size/price[@value = $minprice]/@beforerebate">
													<iaixsl:value-of select="/shop/page/projector/product/sizes/size/price[@value = $minprice]/@beforerebate" />
												</iaixsl:when>
												<iaixsl:otherwise>
													<iaixsl:value-of select="$minprice" />
												</iaixsl:otherwise>
											</iaixsl:choose></iaixsl:attribute>
											<iaixsl:choose>
												<iaixsl:when test="not($nettoPrice = '')">
													<iaixsl:value-of select="/shop/page/projector/product/sizes/prices/@minprice_net_formatted"/>
												</iaixsl:when>
												<iaixsl:otherwise>
													<iaixsl:value-of select="/shop/page/projector/product/sizes/prices/@minprice_formatted"/>
												</iaixsl:otherwise>
											</iaixsl:choose>
										</span>
											<![CDATA[ - ]]>
										<span>
											<!-- SUBSKRYPCJA -->
											<iaixsl:attribute name="data-subscription-max" ><iaixsl:choose>
												<iaixsl:when test="/shop/page/projector/product/sizes/size/price[@value = $maxprice]/@maxprice">
													<iaixsl:value-of select="/shop/page/projector/product/sizes/size/price[@value = $maxprice]/@maxprice" />
												</iaixsl:when>
												<iaixsl:otherwise>
													<iaixsl:value-of select="$maxprice" />
												</iaixsl:otherwise>
											</iaixsl:choose></iaixsl:attribute>
											<!-- SUBSKRYPCJA -->
											<iaixsl:attribute name="data-subscription-max-net" ><iaixsl:choose>
												<iaixsl:when test="/shop/page/projector/product/sizes/size/price[@value = $maxprice]/@maxprice_net">
													<iaixsl:value-of select="/shop/page/projector/product/sizes/size/price[@value = $maxprice]/@maxprice_net" />
												</iaixsl:when>
												<iaixsl:otherwise>
													<iaixsl:value-of select="/shop/page/projector/product/sizes/prices/@maxprice_net" />
												</iaixsl:otherwise>
											</iaixsl:choose></iaixsl:attribute>
											<!-- SUBSKRYPCJA -->
											<iaixsl:attribute name="data-subscription-save" ><iaixsl:value-of select="/shop/page/projector/product/sizes/size/price[@value = $maxprice]/@yousave" /></iaixsl:attribute>
											<!-- SUBSKRYPCJA -->
											<iaixsl:attribute name="data-subscription-before" ><iaixsl:choose>
												<iaixsl:when test="/shop/page/projector/product/sizes/size/price[@value = $maxprice]/@beforerebate">
													<iaixsl:value-of select="/shop/page/projector/product/sizes/size/price[@value = $maxprice]/@beforerebate" />
												</iaixsl:when>
												<iaixsl:otherwise>
													<iaixsl:value-of select="$maxprice" />
												</iaixsl:otherwise>
											</iaixsl:choose></iaixsl:attribute>
											<iaixsl:choose>
												<iaixsl:when test="not($nettoPrice = '')">
													<iaixsl:value-of select="/shop/page/projector/product/sizes/prices/@maxprice_net_formatted"/>
												</iaixsl:when>
												<iaixsl:otherwise>
													<iaixsl:value-of select="/shop/page/projector/product/sizes/prices/@maxprice_formatted"/>
												</iaixsl:otherwise>
											</iaixsl:choose>
										</span>
									</iaixsl:when>
									<iaixsl:otherwise>
										<span>
											<!-- SUBSKRYPCJA -->
											<iaixsl:attribute name="data-subscription-max" ><iaixsl:choose>
												<iaixsl:when test="page/projector/product/price/@maxprice">
													<iaixsl:value-of select="page/projector/product/price/@maxprice" />
												</iaixsl:when>
												<iaixsl:otherwise>
													<iaixsl:value-of select="page/projector/product/price/@value" />
												</iaixsl:otherwise>
											</iaixsl:choose></iaixsl:attribute>
											<!-- SUBSKRYPCJA -->
											<iaixsl:attribute name="data-subscription-max-net" ><iaixsl:choose>
												<iaixsl:when test="page/projector/product/price/@maxprice_net">
													<iaixsl:value-of select="page/projector/product/price/@maxprice_net" />
												</iaixsl:when>
												<iaixsl:otherwise>
													<iaixsl:value-of select="page/projector/product/price/@price_net" />
												</iaixsl:otherwise>
											</iaixsl:choose></iaixsl:attribute>
											<!-- SUBSKRYPCJA -->
											<iaixsl:attribute name="data-subscription-save" ><iaixsl:value-of select="page/projector/product/price/@yousave" /></iaixsl:attribute>
											<!-- SUBSKRYPCJA -->
											<iaixsl:attribute name="data-subscription-before" ><iaixsl:choose>
												<iaixsl:when test="page/projector/product/price/@beforerebate">
													<iaixsl:value-of select="page/projector/product/price/@beforerebate" />
												</iaixsl:when>
												<iaixsl:otherwise>
													<iaixsl:value-of select="page/projector/product/price/@value" />
												</iaixsl:otherwise>
											</iaixsl:choose></iaixsl:attribute>
											<iaixsl:choose>
												<iaixsl:when test="not($nettoPrice = '')">
													<iaixsl:value-of select="page/projector/product/price/@price_net_formatted"/>
												</iaixsl:when>
												<iaixsl:otherwise>
													<iaixsl:value-of select="page/projector/product/price/@price_formatted"/>
												</iaixsl:otherwise>
											</iaixsl:choose>
										</span>
									</iaixsl:otherwise>
								</iaixsl:choose>
							</strong>
							<iaixsl:if test="(page/projector/product/sizes/@unit_sellby != '1') and (page/projector/product/sizes/size &gt; 1)">
								<iaixsl:choose>
									<iaixsl:when test="not($nettoPrice = '')">
										<script class="ajaxLoad">
											<![CDATA[$('#projector_price_value').html(format_price("]]><iaixsl:value-of select="/shop/page/projector/product/sizes/prices/@minprice_net * page/projector/product/sizes/@unit_sellby"/><![CDATA[",{mask: app_shop.vars.currency_format,currency: "]]><iaixsl:value-of select="/shop/currency/@name"/><![CDATA[",currency_space: app_shop.vars.currency_space,currency_before_price: app_shop.vars.currency_before_value})+' - '+format_price("]]><iaixsl:value-of select="/shop/page/projector/product/sizes/prices/@maxprice_net * page/projector/product/sizes/@unit_sellby"/><![CDATA[",{mask: app_shop.vars.currency_format,currency: "]]><iaixsl:value-of select="/shop/currency/@name"/><![CDATA[",currency_space: app_shop.vars.currency_space,currency_before_price: app_shop.vars.currency_before_value}));]]>
										</script>
									</iaixsl:when>
									<iaixsl:otherwise>
										<script class="ajaxLoad">
											<![CDATA[$('#projector_price_value').html(format_price("]]><iaixsl:value-of select="/shop/page/projector/product/sizes/prices/@minprice * page/projector/product/sizes/@unit_sellby"/><![CDATA[",{mask: app_shop.vars.currency_format,currency: "]]><iaixsl:value-of select="/shop/currency/@name"/><![CDATA[",currency_space: app_shop.vars.currency_space,currency_before_price: app_shop.vars.currency_before_value})+' - '+format_price("]]><iaixsl:value-of select="/shop/page/projector/product/sizes/prices/@maxprice * page/projector/product/sizes/@unit_sellby"/><![CDATA[",{mask: app_shop.vars.currency_format,currency: "]]><iaixsl:value-of select="/shop/currency/@name"/><![CDATA[",currency_space: app_shop.vars.currency_space,currency_before_price: app_shop.vars.currency_before_value}));]]>
										</script>
									</iaixsl:otherwise>
								</iaixsl:choose>
							</iaixsl:if>
						</iaixsl:otherwise>
					</iaixsl:choose>

					<div class="projector_prices__info">
						<span class="projector_prices__vat">
							<span class="price_vat"><iaixsl:value-of select="$priceTypeText"/></span>
						</span>
						<span class="projector_prices__unit_sep">
								/
						</span>
						<span class="projector_prices__unit_sellby" id="projector_price_unit_sellby" style="display:none">
							<iaixsl:value-of select="/shop/page/projector/product/sizes/@unit_sellby"/>
						</span>
						<span class="projector_prices__unit" id="projector_price_unit">
							<iaixsl:value-of select="/shop/page/projector/product/sizes/@unit"/>
						</span>
						<iaixsl:if test="/shop/page/projector/bundled/@collection = 'true'">
							<span class="projector_prices__collection_selected"> <iai:variable vid="wybranych produktów"/></span>
						</iaixsl:if>
						<!-- SUBSKRYPCJA -->
						<iaixsl:if test="/shop/page/projector/product/subscriptions/subscription">
							<span class="projector_prices__period"><![CDATA[ ]]><iai:variable vid="co"/> <span class="projector_prices__period_value"><iaixsl:attribute name="data-change-literal-days" ><iaixsl:value-of select="$firstDaysInPeriod" /></iaixsl:attribute><iaixsl:value-of select="$firstDaysInPeriod" /> <iai:variable vid="dni"/></span></span>
						</iaixsl:if>
					</div>
				</div>

				<!-- OMNIBUS - Najniższa cena przed obniżką -->
				<iaixsl:if test="/shop/@omnibus = 1 or (not(/shop/@omnibus) and /shop/page/projector/product/price/@last_price_change_date)">
					<div class="projector_prices__lowest_price projector_lowest_price">
						<iaixsl:attribute name="data-change-date" ><iaixsl:value-of select="/shop/page/projector/product/price/@last_price_change_date" /></iaixsl:attribute>
						<iaixsl:choose>
							<iaixsl:when test="/shop/page/projector/product/price/@additional_label = 'individual_price'">
								<span class="projector_lowest_price__text --individual"><iai:variable vid="Cena profilowana. Najniższa cena produktu w okresie 30 dni przed wprowadzeniem obniżki"/>: </span>
							</iaixsl:when>
							<iaixsl:otherwise>
								<span class="projector_lowest_price__text"><iai:variable vid="Najniższa cena produktu w okresie 30 dni przed wprowadzeniem obniżki"/>: </span>
							</iaixsl:otherwise>
						</iaixsl:choose>
						<span class="projector_lowest_price__value"></span>
					</div>
				</iaixsl:if>

				<!-- SPRZEDAWANE PO -->
				<iaixsl:if test="/shop/page/projector/product/sizes/@unit_sellby != '1'">
					<div class="projector_prices__sellby">
						<span class="projector_prices__sellby_label"><iai:variable vid="Sprzedawane po"/>:</span>
						<span class="projector_prices__sellby_value"><iaixsl:value-of select="page/projector/product/sizes/@unit_sellby"/><span class="projector_prices__sellby_unit"><iaixsl:value-of select="page/projector/product/sizes/@unit"/></span></span>
						<span class="projector_prices__sellbyprice_wrapper" id="projector_sellbyprice_wrapper" style="display:none;"> (<span id="projector_sellbyprice"><iaixsl:choose><iaixsl:when test="not($nettoPrice = '')"><iaixsl:value-of select="/shop/page/projector/product/price/@price_net_formatted"/></iaixsl:when><iaixsl:otherwise><iaixsl:value-of select="/shop/page/projector/product/price/@price_formatted"/></iaixsl:otherwise></iaixsl:choose></span> / 1 <iaixsl:value-of select="page/projector/product/sizes/@unit_single"/>)</span>
					</div>
				</iaixsl:if>

				<!-- CENA ZASADNICZA / JEDNOSTKOWA -->
				<iaixsl:if test="/shop/page/projector/product/price/@unit_converted_price">
					<div class="projector_prices__unit_converted">
						<span class="projector_prices__unit_converted_label"><iai:variable vid="Cena jednostkowa"/></span>
						<strong class="projector_prices__unit_converted_price"><iaixsl:choose><iaixsl:when test="not($nettoPrice = '')"><iaixsl:value-of select="/shop/page/projector/product/price/@unit_converted_price_net_formatted"/></iaixsl:when><iaixsl:otherwise><iaixsl:value-of select="/shop/page/projector/product/price/@unit_converted_price_formatted"/></iaixsl:otherwise></iaixsl:choose><![CDATA[ / ]]><iaixsl:value-of select="/shop/page/projector/product/price/@unit_converted_format"/></strong>
					</div>
				</iaixsl:if>

				<div class="projector_prices__points" id="projector_points_wrapper">
					<iaixsl:if test="not(/shop/page/projector/product/@for_points='true' or page/projector/product/price/@points &gt; 0 )">
						<iaixsl:attribute name="style"><![CDATA[display:none;]]></iaixsl:attribute>
					</iaixsl:if>
					<div class="projector_prices__points_wrapper" id="projector_price_points_wrapper">
						<iaixsl:choose>
							<iaixsl:when test="not(/shop/basket/@login)">
								<span id="projector_button_points_basket" class="projector_prices__points_buy --span">
									<iaixsl:attribute name="title"><iai:variable vid="Zaloguj się, aby kupić ten produkt za punkty"/></iaixsl:attribute>
									<span class="projector_prices__points_price_text"><iai:variable vid="Możesz kupić za"/> </span>
									<span class="projector_prices__points_price" id="projector_price_points"><iaixsl:value-of select="page/projector/product/price/@points"/><span class="projector_currency"> <iai:variable vid="pkt"/>.</span></span>
								</span>
							</iaixsl:when>
							<iaixsl:otherwise>
								<button id="projector_button_points_basket" type="submit" name="forpoints" value="1" class="projector_prices__points_buy">
									<span class="projector_prices__points_price_text"><iai:variable vid="Kup za"/> </span>
									<span class="projector_prices__points_price" id="projector_price_points"><iaixsl:value-of select="page/projector/product/price/@points"/><span class="projector_currency"> <iai:variable vid="pkt"/>.</span></span>
								</button>
							</iaixsl:otherwise>
						</iaixsl:choose>
					</div>
				</div>
			</div>

			<!-- MULTIPACK -->
			<iaixsl:if test="page/projector/product/sizes/size[1]/price/rebateNumber and not(page/projector/product/@product_type = 'product_virtual')">
				<div class="projector_details__multipack projector_multipack" id="projector_rebateNumber">
					<strong class="projector_multipack__label"><iai:variable vid="Zamów więcej, zapłać mniej!"/></strong>
					<div class="projector_multipack__wrapper">
						<iaixsl:for-each select="page/projector/product/sizes/size[1]/price/rebateNumber/rebate">
							<div class="projector_multipack__item f-group --radio">
								<iaixsl:attribute name="data-value"><iaixsl:choose><iaixsl:when test="contains(@threshold, '.00')"><iaixsl:value-of select="format-number(@threshold, '#')"/></iaixsl:when><iaixsl:otherwise><iaixsl:value-of select="@threshold"/></iaixsl:otherwise></iaixsl:choose></iaixsl:attribute>
								<input type="radio" name="multipack_radio" class="f-control">
									<iaixsl:attribute name="id"><![CDATA[multipackRadioItem]]><iaixsl:value-of select="position()"/></iaixsl:attribute>
								</input>
								<label class="f-label">
									<iaixsl:attribute name="for"><![CDATA[multipackRadioItem]]><iaixsl:value-of select="position()"/></iaixsl:attribute>
									<strong class="projector_multipack__from"><iaixsl:choose><iaixsl:when test="contains(@threshold, '.00')"><iaixsl:value-of select="format-number(@threshold, '#')"/></iaixsl:when><iaixsl:otherwise><iaixsl:value-of select="@threshold"/></iaixsl:otherwise></iaixsl:choose></strong>
									<strong class="projector_multipack__unit"><iaixsl:value-of select="/shop/page/projector/product/sizes/@unit"/></strong>
									<span class="projector_multipack__price"><iaixsl:choose><iaixsl:when test="not($nettoPrice = '')"><iaixsl:value-of select="@price_net_formatted"/></iaixsl:when><iaixsl:otherwise><iaixsl:value-of select="@price_formatted"/></iaixsl:otherwise></iaixsl:choose></span>
									<span class="projector_multipack__literal --first">(-</span>
									<span class="projector_multipack__percent"><iaixsl:choose><iaixsl:when test="contains(@value, '.00')"><iaixsl:value-of select="format-number(@value, '#')"/></iaixsl:when><iaixsl:otherwise><iaixsl:value-of select="@value"/></iaixsl:otherwise></iaixsl:choose></span>
									<span class="projector_multipack__literal --second">%)</span>
								</label>
							</div>
						</iaixsl:for-each>
					</div>
				</div>
			</iaixsl:if>

			<!-- SUBSKRYPCJA - OPCJE  -->
			<iaixsl:if test="/shop/page/projector/product/subscriptions/subscription">
				<div class="projector_details__subscription projector_subscription">
					<iaixsl:if test="(/shop/page/projector/product/@product_type = 'product_configurable' and /shop/page/projector/product/priceFormula) or /shop/page/projector/bundled/product or /shop/page/projector/product/versions/@count &gt; 0 or not(/shop/page/projector/product/sizes/size/@type = 'onesize' or /shop/page/projector/product/sizes/size/@type = 'uniw')">
						<iaixsl:attribute name="data-border" ><![CDATA[true]]></iaixsl:attribute>
					</iaixsl:if>
					<span class="projector_subscription__label"><iai:variable vid="Wysyłka co"/></span>
					<div class="projector_subscription__sub">
						<iaixsl:for-each select="/shop/page/projector/product/subscriptions/subscription">
							<iaixsl:sort select="@days_in_period" data-type="number"/>
							<a class="projector_subscription__item">
								<iaixsl:attribute name="class"><![CDATA[projector_subscription__item]]><iaixsl:if test="position() = 1"><![CDATA[ --selected]]></iaixsl:if></iaixsl:attribute>
								<iaixsl:attribute name="href"><iaixsl:value-of select="/shop/page/projector/product/@link"/><![CDATA[?selected_subscription=]]><iaixsl:value-of select="@days_in_period"/></iaixsl:attribute>
								<iaixsl:attribute name="data-days"><iaixsl:value-of select="@days_in_period"/></iaixsl:attribute>
								<iaixsl:if test="rebate">
									<iaixsl:attribute name="data-rebate-type" ><iaixsl:value-of select="rebate/@type" /></iaixsl:attribute>
									<iaixsl:attribute name="data-rebate-value" ><iaixsl:value-of select="rebate/@value" /></iaixsl:attribute>
									<iaixsl:attribute name="data-rebate-value-formatted" ><iaixsl:value-of select="rebate/@value_formatted" /></iaixsl:attribute>
								</iaixsl:if>
								<span class="projector_subscription__name"><iaixsl:attribute name="data-change-literal-days" ><iaixsl:value-of select="@days_in_period" /></iaixsl:attribute><iaixsl:value-of select="@days_in_period"/> <iai:variable vid="dni"/></span>
							</a>
						</iaixsl:for-each>
					</div>
				</div>
			</iaixsl:if>

			<!-- KONFIGURATOR - SKELETON -->
			<iaixsl:if test="/shop/page/projector/product/@product_type = 'product_configurable' and /shop/page/projector/product/priceFormula">
				<div class="configurator --skeleton">
					<iaixsl:for-each select="/shop/page/projector/product/priceFormula/parameters/parameter">
						<div class="configurator__item">
							<iaixsl:attribute name="data-type"><iaixsl:value-of select="type"/></iaixsl:attribute>
							<span class="configurator__label"/>
							<div class="configurator__sub">
								<iaixsl:attribute name="data-type"><iaixsl:value-of select="type"/></iaixsl:attribute>
								<iaixsl:choose>
									<iaixsl:when test="type = 'radio'">
										<iaixsl:for-each select="values/value">
											<div class="f-group --radio"/>
										</iaixsl:for-each>
									</iaixsl:when>
									<iaixsl:when test="type = 'select'">
										<div class="f-select"/>
									</iaixsl:when>
									<iaixsl:when test="type = 'checkbox'">
										<iaixsl:for-each select="values/value">
											<div class="f-group --checkbox"/>
										</iaixsl:for-each>
									</iaixsl:when>
									<iaixsl:when test="type = 'input'">
										<div class="f-group"/>
										<iaixsl:if test="settings/min or settings/max">
											<div class="configurator__limits"/>
										</iaixsl:if>
									</iaixsl:when>
								</iaixsl:choose>
							</div>
						</div>
					</iaixsl:for-each>
				</div>
			</iaixsl:if>

			<!-- ZESTAWY - SKELETON -->
			<iaixsl:if test="page/projector/bundled/product">
				<div class="projector_bundle --skeleton">
					<iaixsl:if test="/shop/page/projector/bundled/@collection = 'true'">
						<iaixsl:attribute name="data-collection"><![CDATA[true]]></iaixsl:attribute>
					</iaixsl:if>
					<iaixsl:if test="/shop/page/projector/bundled/@left_quantity and not(/shop/page/projector/product/bundle_price/@amount_diff_gross = '0.00')">
						<div class="projector_bundle__rebate">
							<h2 class="projector_bundle__rebate_label"/>
							<div class="projector_bundle__rebate_wrapper">
								<span class="projector_bundle__rebate_description"/>
							</div>
						</div>
					</iaixsl:if>

					<h2 class="projector_bundle__label"/>

					<div class="projector_bundle__block">
						<iaixsl:for-each select="page/projector/bundled/product">
							<div class="projector_bundle__item">
								<iaixsl:if test="/shop/page/projector/bundled/@collection='true'">
									<div class="projector_bundle__checkbox_group f-group --checkbox"/>
								</iaixsl:if>

								<a class="projector_bundle__icon"/>

								<div class="projector_bundle__info">
									<a class="projector_bundle__name"/>

									<div class="projector_bundle__price_wrapper"/>

									<div class="projector_bundle__options">
										<iaixsl:if test="sizes/size/@type='onesize' and not(multiversions and versions/@version_choice='true') and not(sizes_chart)">
											<iaixsl:attribute name="data-only_onesize"><![CDATA[true]]></iaixsl:attribute>
										</iaixsl:if>
										<iaixsl:if test="multiversions and versions/@version_choice='true'">
											<iaixsl:for-each select="multiversions/multi_version">
												<div class="projector_bundle__option --versions">
													<div class="projector_bundle__version"/>
												</div>
											</iaixsl:for-each>
										</iaixsl:if>

										<div class="projector_bundle__option --sizes">
											<iaixsl:if test="multiversions and versions/@version_choice='true'">
												<iaixsl:attribute name="data-hide"><![CDATA[true]]></iaixsl:attribute>
											</iaixsl:if>
											<iaixsl:if test="sizes/size/@type='onesize'">
												<iaixsl:attribute name="data-onesize"><![CDATA[true]]></iaixsl:attribute>
											</iaixsl:if>
											<div class="projector_bundle__size"/>
										</div>

										<iaixsl:if test="sizes_chart">
											<div class="projector_bundle__option --chart">
												<div class="projector_bundle__chart_link"/>
											</div>
										</iaixsl:if>
									</div>
								</div>
							</div>
						</iaixsl:for-each>
					</div>
				</div>
			</iaixsl:if>

			<!-- MULTIWARIANT -->
			<iaixsl:if test="(/shop/page/projector/product/multiversions) and (count(/shop/page/projector/product/multiversions/multi_version) &gt; 1)">
				<div id="multi_versions" class="projector_details__multiversions projector_multiversions">
					<iaixsl:for-each select="/shop/page/projector/product/multiversions/multi_version">
						<div class="projector_multiversions__item">
							<iaixsl:attribute name="data-id"><iaixsl:value-of select="@id"/></iaixsl:attribute>
							<span class="projector_multiversions__label"><iaixsl:value-of disable-output-escaping="yes" select="@name"/></span>
							<div class="projector_multiversions__sub">
								<select class="projector_multiversions__select f-select">
									<iaixsl:for-each select="item">
										<option>
											<iaixsl:variable name="value_name"><iaixsl:for-each select="values/value"><iaixsl:if test="not(position() = 1)"> / </iaixsl:if><iaixsl:value-of disable-output-escaping="yes" select="@name"/></iaixsl:for-each></iaixsl:variable>
											<iaixsl:if test="@selected = 'true'">
												<iaixsl:attribute name="selected"><![CDATA[selected]]></iaixsl:attribute>
											</iaixsl:if>
											<iaixsl:if test="@disabled = 'true'">
												<iaixsl:attribute name="class"><![CDATA[--dependent]]></iaixsl:attribute>
											</iaixsl:if>
											<iaixsl:attribute name="data-values_id"><iaixsl:value-of select="values/@id"/></iaixsl:attribute>
											<iaixsl:attribute name="data-value"><iaixsl:value-of select="position()"/></iaixsl:attribute>
											<iaixsl:attribute name="data-title"><iaixsl:value-of select="$value_name"/></iaixsl:attribute>
											<iaixsl:attribute name="data-product"><iaixsl:value-of select="products/product/@product_id"/></iaixsl:attribute>
											<iaixsl:attribute name="data-link"><iaixsl:value-of select="products/product/@url"/></iaixsl:attribute>
											<iaixsl:if test="values/value[@gfx]">
												<iaixsl:attribute name="data-gfx"><iaixsl:for-each select="values/value[@gfx]"><iaixsl:if test="not(position() = 1)"><![CDATA[|next|]]></iaixsl:if><iaixsl:value-of select="@gfx"/></iaixsl:for-each></iaixsl:attribute>
											</iaixsl:if>
											<iaixsl:value-of select="$value_name"/>
										</option>
									</iaixsl:for-each>
								</select>
							</div>
						</div>
					</iaixsl:for-each>
				</div>
			</iaixsl:if>

			<!-- WARIANT -->
			<iaixsl:if test="(/shop/page/projector/product/versions/@count &gt; 0) and not(count(/shop/page/projector/product/multiversions/multi_version) &gt; 1)">
				<div id="versions" class="projector_details__versions projector_versions">
					<iaixsl:if test="(not($selectForVersions = '') and /shop/page/projector/product/versions/@count &gt; $selectForVersions) or count(/shop/page/projector/product/versions/version[not(@gfx)]) &gt; 0">
						<iaixsl:attribute name="data-select"><![CDATA[true]]></iaixsl:attribute>
					</iaixsl:if>
					<span class="projector_versions__label"><iaixsl:value-of disable-output-escaping="yes" select="/shop/page/projector/product/versions/@name"/></span>
					<div class="projector_versions__sub">
						<iaixsl:choose>
							<iaixsl:when test="(not($selectForVersions = '') and /shop/page/projector/product/versions/@count &gt; $selectForVersions) or count(/shop/page/projector/product/versions/version[not(@gfx)]) &gt; 0">
								<select class="projector_versions__select f-select">
									<iaixsl:for-each select="/shop/page/projector/product/versions/version">
										<option>
											<iaixsl:if test="@id = /shop/page/projector/product/@id">
												<iaixsl:attribute name="selected"><![CDATA[selected]]></iaixsl:attribute>
											</iaixsl:if>
											<iaixsl:if test="@amount = '0'">
												<iaixsl:attribute name="class"><![CDATA[--disabled]]></iaixsl:attribute>
												<iaixsl:attribute name="label"><iaixsl:value-of select="@name"/> (<iai:variable vid="wyprzedane"/>)</iaixsl:attribute>
											</iaixsl:if>
											<iaixsl:attribute name="data-link"><iaixsl:value-of select="@link"/></iaixsl:attribute>
											<iaixsl:if test="@gfx">
												<iaixsl:attribute name="data-gfx"><iaixsl:value-of select="@gfx"/></iaixsl:attribute>
											</iaixsl:if>
											<iaixsl:value-of select="@name"/>
										</option>
									</iaixsl:for-each>
								</select>
							</iaixsl:when>
							<iaixsl:otherwise>
								<iaixsl:for-each select="/shop/page/projector/product/versions/version">
									<a class="projector_versions__item">
										<iaixsl:attribute name="class"><![CDATA[projector_versions__item]]><iaixsl:if test="@id = /shop/page/projector/product/@id"><![CDATA[ --selected]]></iaixsl:if><iaixsl:if test="@amount = '0'"><![CDATA[ --disabled]]></iaixsl:if></iaixsl:attribute>
										<iaixsl:attribute name="href"><iaixsl:value-of select="@link"/></iaixsl:attribute>
										<iaixsl:attribute name="title"><iaixsl:value-of select="@name"/></iaixsl:attribute>
										<iaixsl:if test="@gfx">
											<span class="projector_versions__gfx">
												<img>
													<iaixsl:attribute name="src"><iaixsl:value-of select="@gfx"/></iaixsl:attribute>
													<iaixsl:attribute name="alt"><iaixsl:value-of select="@name"/></iaixsl:attribute>
												</img>
											</span>
										</iaixsl:if>
										<span class="projector_versions__name"><iaixsl:value-of disable-output-escaping="yes" select="@name"/></span>
									</a>
								</iaixsl:for-each>
							</iaixsl:otherwise>
						</iaixsl:choose>
					</div>
				</div>
			</iaixsl:if>

			<!-- TABELA ROZMIAROWA -->
			<iaixsl:if test="(/shop/page/projector/text_sizesgroup and /shop/page/projector/text_sizesgroup != '') or /shop/page/projector/product/sizes_chart">
				<div id="projector_chart" class="projector_details__chart projector_chart">
					<a href="#showSizesCms" class="projector_chart__link"><iai:variable vid="Sprawdź wymiary produktu"/></a>
				</div>
			</iaixsl:if>

			<!-- ROZMIAR -->
			<div id="projector_sizes_cont" class="projector_details__sizes projector_sizes">
				<iaixsl:if test="/shop/page/projector/product/sizes/size/@type = 'onesize' or /shop/page/projector/product/sizes/size/@type = 'uniw'">
					<iaixsl:attribute name="data-onesize"><![CDATA[true]]></iaixsl:attribute>
				</iaixsl:if>
				<iaixsl:if test="not($selectForSizes = '') and count(/shop/page/projector/product/sizes/size) &gt; $selectForSizes">
					<iaixsl:attribute name="data-select"><![CDATA[true]]></iaixsl:attribute>
				</iaixsl:if>
				<span class="projector_sizes__label"><iai:variable vid="Rozmiar"/></span>
				<div class="projector_sizes__sub">
					<iaixsl:choose>
						<iaixsl:when test="not($selectForSizes = '') and count(/shop/page/projector/product/sizes/size) &gt; $selectForSizes">
							<select name="projector_sizes" id="projector_sizes_select" class="projector_sizes__select f-select --placeholder">
								<option><iai:variable vid="Wybierz rozmiar"/></option>
								<iaixsl:for-each select="/shop/page/projector/product/sizes/size">
									<option>
										<iaixsl:if test="@selected = 'true'">
											<iaixsl:attribute name="selected"><![CDATA[selected]]></iaixsl:attribute>
										</iaixsl:if>
										<iaixsl:if test="@amount = '0'">
											<iaixsl:attribute name="class"><![CDATA[--disabled]]></iaixsl:attribute>
											<iaixsl:attribute name="label"><iaixsl:value-of select="@description"/> (<iai:variable vid="wyprzedane"/>)</iaixsl:attribute>
										</iaixsl:if>
										<iaixsl:attribute name="value"><iaixsl:value-of select="@type"/></iaixsl:attribute>
										<iaixsl:attribute name="data-count"><iaixsl:value-of select="@amount"/></iaixsl:attribute>
										<iaixsl:if test="availability/@status_id">
											<iaixsl:attribute name="data-statusid"><iaixsl:value-of select="availability/status_id"/></iaixsl:attribute>
										</iaixsl:if>
										<iaixsl:value-of select="@description"/>
									</option>
								</iaixsl:for-each>
							</select>
						</iaixsl:when>
						<iaixsl:otherwise>
							<iaixsl:for-each select="/shop/page/projector/product/sizes/size">
								<a class="projector_sizes__item">
									<iaixsl:attribute name="class"><![CDATA[projector_sizes__item]]><iaixsl:if test="not(@amount &gt; 0 or @amount = '-1')"><![CDATA[ --disabled]]></iaixsl:if><iaixsl:if test="@selected = 'true'"><![CDATA[ --selected]]></iaixsl:if></iaixsl:attribute>
									<iaixsl:attribute name="href"><iaixsl:value-of select="/shop/page/projector/product/@link"/><![CDATA[?selected_size=]]><iaixsl:value-of select="@type"/></iaixsl:attribute>
									<iaixsl:attribute name="data-type"><iaixsl:value-of select="@type"/></iaixsl:attribute>
									<span class="projector_sizes__name"><iaixsl:value-of select="@description"/></span>
								</a>
							</iaixsl:for-each>
						</iaixsl:otherwise>
					</iaixsl:choose>
				</div>
			</div>

			<!-- ZALICZKA -->
			<iaixsl:if test="page/projector/product/price/@advanceprice_formatted">
				<div class="projector_details__advanceprice" id="projector_advanceprice_wrapper">
					<iai:variable vid="Przed realizacją zamówienia z tym produktem, może być konieczne opłacenie zaliczki w kwocie"/> <b id="projector_advanceprice"><iaixsl:choose><iaixsl:when test="not($nettoPrice = '')"><iaixsl:value-of select="page/projector/product/price/@advanceprice_net_formatted"/></iaixsl:when><iaixsl:otherwise><iaixsl:value-of select="page/projector/product/price/@advanceprice_formatted"/></iaixsl:otherwise></iaixsl:choose></b>. <iai:variable vid="Dokładne informacje zostaną podane w podsumowaniu zamówienia, przed jego złożeniem"/>.
				</div>
			</iaixsl:if>

			<!-- DODANIE DO KOSZYKA -->
			<div class="projector_details__buy projector_buy" id="projector_buy_section">
				<div class="projector_buy__wrapper">
					<iaixsl:if test="not(/shop/page/projector/product/@product_type = 'product_virtual')">
						<div class="projector_buy__number_wrapper">
							<select class="projector_buy__number f-select">
								<iaixsl:if test="page/projector/product/exchange/@exchange_id">
									<iaixsl:attribute name="disabled"><![CDATA[disabled]]></iaixsl:attribute>
								</iaixsl:if>
							<!-- SUBSKRYPCJA -->
							<option>
									<iaixsl:attribute name="value"><iaixsl:value-of select="1 * /shop/page/projector/product/sizes/@unit_sellby"/></iaixsl:attribute>
								<!-- SUBSKRYPCJA -->
                <iaixsl:if test="(1 * /shop/page/projector/product/sizes/@unit_sellby) = /shop/page/projector/product/subscriptions/@minimum_quantity or not(/shop/page/projector/product/subscriptions/@minimum_quantity)">
                  <iaixsl:attribute name="selected" ><![CDATA[selected]]></iaixsl:attribute>
                </iaixsl:if>
									<iaixsl:value-of select="1 * /shop/page/projector/product/sizes/@unit_sellby"/>
								</option>
								<option>
									<iaixsl:attribute name="value"><iaixsl:value-of select="2 * /shop/page/projector/product/sizes/@unit_sellby"/></iaixsl:attribute>
								<!-- SUBSKRYPCJA -->
                <iaixsl:if test="(2 * /shop/page/projector/product/sizes/@unit_sellby) = /shop/page/projector/product/subscriptions/@minimum_quantity">
                  <iaixsl:attribute name="selected" ><![CDATA[selected]]></iaixsl:attribute>
                </iaixsl:if>
									<iaixsl:value-of select="2 * /shop/page/projector/product/sizes/@unit_sellby"/>
								</option>
								<option>
									<iaixsl:attribute name="value"><iaixsl:value-of select="3 * /shop/page/projector/product/sizes/@unit_sellby"/></iaixsl:attribute>
								<!-- SUBSKRYPCJA -->
                <iaixsl:if test="(3 * /shop/page/projector/product/sizes/@unit_sellby) = /shop/page/projector/product/subscriptions/@minimum_quantity">
                  <iaixsl:attribute name="selected" ><![CDATA[selected]]></iaixsl:attribute>
                </iaixsl:if>
									<iaixsl:value-of select="3 * /shop/page/projector/product/sizes/@unit_sellby"/>
								</option>
								<option>
									<iaixsl:attribute name="value"><iaixsl:value-of select="4 * /shop/page/projector/product/sizes/@unit_sellby"/></iaixsl:attribute>
								<!-- SUBSKRYPCJA -->
                <iaixsl:if test="(4 * /shop/page/projector/product/sizes/@unit_sellby) = /shop/page/projector/product/subscriptions/@minimum_quantity">
                  <iaixsl:attribute name="selected" ><![CDATA[selected]]></iaixsl:attribute>
                </iaixsl:if>
									<iaixsl:value-of select="4 * /shop/page/projector/product/sizes/@unit_sellby"/>
								</option>
								<option>
									<iaixsl:attribute name="value"><iaixsl:value-of select="5 * /shop/page/projector/product/sizes/@unit_sellby"/></iaixsl:attribute>
								<!-- SUBSKRYPCJA -->
                <iaixsl:if test="(5 * /shop/page/projector/product/sizes/@unit_sellby) = /shop/page/projector/product/subscriptions/@minimum_quantity">
                  <iaixsl:attribute name="selected" ><![CDATA[selected]]></iaixsl:attribute>
                </iaixsl:if>
									<iaixsl:value-of select="5 * /shop/page/projector/product/sizes/@unit_sellby"/>
								</option>
								<option>
									<iaixsl:attribute name="data-more"><![CDATA[true]]></iaixsl:attribute>
									<iai:variable vid="więcej"/>
								</option>
							</select>
							<div class="projector_buy__more">
								<input class="projector_buy__more_input" type="number" name="number" id="projector_number">
									<!-- SUBSKRYPCJA -->
									<iaixsl:choose>
										<iaixsl:when test="/shop/page/projector/product/subscriptions/@minimum_quantity">
											<iaixsl:attribute name="data-prev" ><iaixsl:value-of select="/shop/page/projector/product/subscriptions/@minimum_quantity"/></iaixsl:attribute>
											<iaixsl:attribute name="value" ><iaixsl:value-of select="/shop/page/projector/product/subscriptions/@minimum_quantity"/></iaixsl:attribute>
											<iaixsl:attribute name="data-minimum-quantity-subscription" ><iaixsl:value-of select="/shop/page/projector/product/subscriptions/@minimum_quantity" /></iaixsl:attribute>
										</iaixsl:when>
										<iaixsl:otherwise>
											<iaixsl:attribute name="data-prev"><iaixsl:value-of select="/shop/page/projector/product/sizes/@unit_sellby"/></iaixsl:attribute>
											<iaixsl:attribute name="value"><iaixsl:value-of select="/shop/page/projector/product/sizes/@unit_sellby"/></iaixsl:attribute>
										</iaixsl:otherwise>
									</iaixsl:choose>
									<!-- SUBSKRYPCJA -->
									<iaixsl:if test="/shop/page/projector/product/order_quantity_range/min_quantity_per_order">
										<iaixsl:attribute name="data-minimum-quantity" ><iaixsl:value-of select="/shop/page/projector/product/order_quantity_range/min_quantity_per_order/text()" /></iaixsl:attribute>
									</iaixsl:if>
									<iaixsl:attribute name="data-sellby"><iaixsl:value-of select="/shop/page/projector/product/sizes/@unit_sellby"/></iaixsl:attribute>
									<iaixsl:attribute name="step"><iaixsl:value-of select="/shop/page/projector/product/sizes/@unit_sellby"/></iaixsl:attribute>
								</input>
							</div>
						</div>
					</iaixsl:if>
					<button class="projector_buy__button btn --solid --large" id="projector_button_basket" type="submit">
						<iaixsl:choose>
						<!-- SUBSKRYPCJA -->
						<iaixsl:when test="/shop/page/projector/product/subscriptions/subscription">
              <iaixsl:attribute name="data-subscription-name" ><iai:variable vid="Subskrybuj"/></iaixsl:attribute>
              <iaixsl:attribute name="data-normal-name" ><iai:variable vid="Dodaj do koszyka"/></iaixsl:attribute>
							<iai:variable vid="Subskrybuj"/>
						</iaixsl:when>
							<iaixsl:when test="page/projector/product/exchange/@exchange_id">
								<iai:variable vid="Wymień produkt"/>
							</iaixsl:when>
							<iaixsl:when test="/shop/page/projector/bundled/@collection = 'true'">
								<iai:variable vid="Dodaj do koszyka"/>
							</iaixsl:when>
							<iaixsl:otherwise>
								<iai:variable vid="Dodaj do koszyka"/>
							</iaixsl:otherwise>
						</iaixsl:choose>
					</button>
					<!-- LISTA ZAKUPOWA -->
					<a class="projector_buy__shopping_list" href="#addToShoppingList">
						<iaixsl:attribute name="title"><iai:variable vid="Kliknij, aby dodać produkt do listy zakupowej"/></iaixsl:attribute>
					</a>
				</div>
			</div>

			<!-- POWIADOM O DOSTĘPNOŚCI -->
			<div class="projector_details__tell_availability projector_tell_availability" id="projector_tell_availability">
				<iaixsl:attribute name="style"><![CDATA[display:none]]></iaixsl:attribute>
				<div class="projector_tell_availability__block --link">
					<a class="projector_tell_availability__link btn --solid --outline --solid --extrasmall" href="#tellAvailability"><iai:variable vid="Powiadom mnie o dostępności produktu"/></a>
				</div>
				<div class="projector_tell_availability__block --dialog" id="tell_availability_dialog">
					<h6 class="headline">
						<span class="headline__name"><iai:variable vid="Produkt wyprzedany"/></span>
					</h6>
					<div class="projector_tell_availability__info_top">
						<span><iai:variable vid="Otrzymasz od nas powiadomienie e-mail o ponownej dostępności produktu"/>.</span>
					</div>
					<div class="projector_tell_availability__email f-group --small">
						<div class="f-feedback --required">
							<input type="text" class="f-control validate" name="email" data-validation-url="/ajax/client-new.php?validAjax=true" data-validation="client_email" required="required" disabled="disabled" id="tellAvailabilityEmail">
								<iaixsl:if test="/shop/client_data/@email">
									<iaixsl:attribute name="value" ><iaixsl:value-of select="/shop/client_data/@email" /></iaixsl:attribute>
								</iaixsl:if>
							</input>
							<label class="f-label" for="tellAvailabilityEmail"><iai:variable vid="Twój adres e-mail"/></label>
							<span class="f-control-feedback"/>
						</div>
					</div>
					<div class="projector_tell_availability__button_wrapper">
						<button type="submit" class="projector_tell_availability__button btn --solid --large">
							<iai:variable vid="Powiadom o dostępności"/>
						</button>
					</div>
					<div class="projector_tell_availability__info1">
						<span><iai:variable vid="Dane są przetwarzane zgodnie z"/> </span><a><iaixsl:attribute name="href"><iaixsl:value-of select="/shop/action/private_policy/@url"/></iaixsl:attribute><iai:variable vid="polityką prywatności"/></a><span>. <iai:variable vid="Przesyłając je, akceptujesz jej postanowienia"/>. </span>
					</div>
					<div class="projector_tell_availability__info2">
						<span><iai:variable vid="Powyższe dane nie są używane do przesyłania newsletterów lub innych reklam. Włączając powiadomienie zgadzasz się jedynie na wysłanie jednorazowo informacji o ponownej dostępności tego produktu"/>. </span>
					</div>
				</div>
			</div>

			<!-- 1-CLICK -->
			<iaixsl:if test="/shop/oneclick/payment">
				<div class="projector_details__oneclick projector_oneclick">
					<iaixsl:attribute name="data-lang"><iaixsl:value-of select="/shop/language/option[@selected ='true']/@id"/></iaixsl:attribute>
					<iaixsl:if test="/shop/page/projector/product/name = ''">
						<iaixsl:attribute name="data-hide" ><![CDATA[true]]></iaixsl:attribute>
					</iaixsl:if>
					<div class="projector_oneclick__label">
						<div class="projector_oneclick__info">
							<span class="projector_oneclick__text --fast"><iai:variable vid="Szybkie zakupy"/> <strong>1-Click</strong></span>
							<span class="projector_oneclick__text --registration">(<iai:variable vid="bez rejestracji"/>)</span>
						</div>
					</div>
					<div class="projector_oneclick__items">
						<iaixsl:for-each select="/shop/oneclick/payment">
							<div>
								<iaixsl:attribute name="class"><![CDATA[projector_oneclick__item --]]><iaixsl:value-of select="@id"/><iaixsl:if test="@preloading"><![CDATA[ --loading]]></iaixsl:if></iaixsl:attribute>
								<iaixsl:attribute name="title"><iai:variable vid="Kliknij i kup bez potrzeby rejestracji z"/> <iaixsl:value-of select="@name"/></iaixsl:attribute>
								<iaixsl:attribute name="id"><![CDATA[oneclick_]]><iaixsl:value-of select="@id"/></iaixsl:attribute>
								<iaixsl:attribute name="data-id"><iaixsl:value-of select="@id"/></iaixsl:attribute>
								<iaixsl:if test="not(@basket_only = 'true')">
									<img class="projector_oneclick__icon">
										<iaixsl:attribute name="src"><iaixsl:value-of select="@icon"/></iaixsl:attribute>
										<iaixsl:attribute name="alt"><iaixsl:value-of select="@name"/></iaixsl:attribute>
									</img>
								</iaixsl:if>
							</div>
						</iaixsl:for-each>
					</div>
				</div>
			</iaixsl:if>

			<div class="projector_details__info projector_info">
				<!-- STATUS DOSTĘPNOŚCI -->
				<div id="projector_status" class="projector_info__item --status projector_status">
					<iaixsl:choose>
						<iaixsl:when test="/shop/page/projector/product/sizes/size[not(@amount_mw = 0)]">
							<iaixsl:if test="/shop/page/projector/product/sizes/size[not(@amount_mw = 0)]/availability/@visible = 'n'">
								<iaixsl:attribute name="class"><![CDATA[projector_info__item --status projector_status --status-hide]]></iaixsl:attribute>
							</iaixsl:if>
						</iaixsl:when>
						<iaixsl:when test="/shop/page/projector/product/sizes/size[not(@amount = 0)]">
							<iaixsl:if test="/shop/page/projector/product/sizes/size[not(@amount = 0)]/availability/@visible = 'n'">
								<iaixsl:attribute name="class"><![CDATA[projector_info__item --status projector_status --status-hide]]></iaixsl:attribute>
							</iaixsl:if>
						</iaixsl:when>
						<iaixsl:when test="/shop/page/projector/product/sizes/size/availability/@visible = 'n'">
								<iaixsl:attribute name="class"><![CDATA[projector_info__item --status projector_status --status-hide]]></iaixsl:attribute>
						</iaixsl:when>
					</iaixsl:choose>
					<span id="projector_status_gfx_wrapper" class="projector_status__gfx_wrapper projector_info__icon">
						<img id="projector_status_gfx" class="projector_status__gfx">
							<iaixsl:choose>
								<iaixsl:when test="/shop/page/projector/product/sizes/size[not(@amount_mw = 0)]/availability/@status_gfx">
									<iaixsl:attribute name="src"><iaixsl:value-of select="/shop/page/projector/product/sizes/size[not(@amount_mw = 0)]/availability/@status_gfx"/></iaixsl:attribute>
									<iaixsl:attribute name="alt"><iaixsl:value-of select="/shop/page/projector/product/sizes/size[not(@amount_mw = 0)]/availability/@status_description"/></iaixsl:attribute>
								</iaixsl:when>
								<iaixsl:when test="/shop/page/projector/product/sizes/size[not(@amount = 0)]/availability/@status_gfx">
									<iaixsl:attribute name="src"><iaixsl:value-of select="/shop/page/projector/product/sizes/size[not(@amount = 0)]/availability/@status_gfx"/></iaixsl:attribute>
									<iaixsl:attribute name="alt"><iaixsl:value-of select="/shop/page/projector/product/sizes/size[not(@amount = 0)]/availability/@status_description"/></iaixsl:attribute>
								</iaixsl:when>
								<iaixsl:otherwise>
									<iaixsl:attribute name="src"><iaixsl:value-of select="/shop/page/projector/product/sizes/size/availability/@status_gfx"/></iaixsl:attribute>
									<iaixsl:attribute name="alt"><iaixsl:value-of select="/shop/page/projector/product/sizes/size/availability/@status_description"/></iaixsl:attribute>
								</iaixsl:otherwise>
							</iaixsl:choose>
						</img>
					</span>

					<!-- NIEZNANY CZAS WYSYŁKI -->
					<div id="projector_shipping_unknown" class="projector_status__unknown">
						<iaixsl:attribute name="style"><![CDATA[display:none]]></iaixsl:attribute>
						<span class="projector_status__unknown_text">
							<a target="_blank"><iaixsl:attribute name="href"><iaixsl:value-of select="/shop/contact/link/@url"/></iaixsl:attribute><iai:variable vid="Skontaktuj się z obsługą sklepu"/></a>, <iai:variable vid="aby oszacować czas przygotowania tego produktu do wysyłki"/>.
						</span>
					</div>

					<div id="projector_status_wrapper" class="projector_status__wrapper">
						<!-- STATUS DOSTĘPNOŚCI - OPIS -->
						<div class="projector_status__description" id="projector_status_description">
							<iaixsl:choose>
								<iaixsl:when test="/shop/page/projector/product/sizes/size[not(@amount_mw = 0)]/availability/@status_description">
									<iaixsl:value-of disable-output-escaping="yes" select="/shop/page/projector/product/sizes/size[not(@amount_mw = 0)]/availability/@status_description"/>
								</iaixsl:when>
								<iaixsl:when test="/shop/page/projector/product/sizes/size[not(@amount = 0)]/availability/@status_description">
									<iaixsl:value-of disable-output-escaping="yes" select="/shop/page/projector/product/sizes/size[not(@amount = 0)]/availability/@status_description"/>
								</iaixsl:when>
								<iaixsl:otherwise>
									<iaixsl:value-of disable-output-escaping="yes" select="/shop/page/projector/product/sizes/size/availability/@status_description"/>
								</iaixsl:otherwise>
							</iaixsl:choose>
						</div>

						<!-- INFO O CZASIE DOSTAWY -->
						<iaixsl:if test="not(/shop/page/projector/product/@product_type = 'product_service')">
							<div id="projector_shipping_info" class="projector_status__info">
								<iaixsl:attribute name="style"><![CDATA[display:none]]></iaixsl:attribute>
								<strong class="projector_status__info_label" id="projector_delivery_label"><iai:variable vid="Wysyłka"/> </strong>
								<strong class="projector_status__info_days" id="projector_delivery_days"/>
								<iaixsl:if test="not(/shop/page/projector/product/@product_type = 'product_bundle')">
								</iaixsl:if>
							</div>
						</iaixsl:if>
					</div>
				</div>
				
				<!-- ZWROTY -->
				<!-- ZABLOKOWANE ZWROTY #1236940752 -->
				<iaixsl:variable name="allow_returns_projector"><iaixsl:choose><iaixsl:when test="/shop/basket/@wholesaler = 'true' and /shop/basket/@blocked_wholesale_returns = 'true'"><![CDATA[false]]></iaixsl:when><iaixsl:otherwise><![CDATA[true]]></iaixsl:otherwise></iaixsl:choose></iaixsl:variable>
				<iaixsl:if test="page/projector/returns_config/@active='y' and not(page/projector/product/@product_type = 'product_virtual' or page/projector/product/@product_type = 'product_service') and $allow_returns_projector = 'true'">
					<div class="projector_info__item --returns projector_returns">
						<span class="projector_returns__icon projector_info__icon"/>
						<span class="projector_returns__info projector_info__link">
              <iaixsl:choose>
                  <iaixsl:when test="/shop/page/projector/returns_config/@returns_shop_shipping_cost != 'client'"> 
                      <iai:variable vid="Darmowy zwrot w ciągu"/>
                  </iaixsl:when>
                  <iaixsl:otherwise> 
                      <iai:variable vid="Łatwy zwrot w ciągu"/>
                  </iaixsl:otherwise>
              </iaixsl:choose>
              <span class="projector_returns__days">
                  <iaixsl:value-of select="page/projector/returns_config/@days_to_return"/>
              </span>
              <iai:variable vid="dni"/>
            </span>
					</div>
				</iaixsl:if>

				<!-- CZAS I KOSZT WYSYŁKI -->
				<div class="projector_info__item --shipping projector_shipping" id="projector_shipping_dialog">
					<iaixsl:if test="(/shop/page/projector/product/sizes/size/availability/delay_time/@unknown_delivery_time = 'true') or (/shop/page/projector/bundled/product/sizes/size/availability/delay_time/@unknown_delivery_time = 'true') or /shop/page/projector/product/@product_type = 'product_service'">
						<iaixsl:attribute name="style"><![CDATA[display:none;]]></iaixsl:attribute>
					</iaixsl:if>
					<span class="projector_shipping__icon projector_info__icon"/>
					<a class="projector_shipping__info projector_info__link" href="#shipping_info">
						<iaixsl:choose>
							<iaixsl:when test="/shop/page/projector/product/smile or (/shop/basket/@shipping = '0.00' and /shop/page/projector/product/sizes/size/delivery/@shipping = '0.00') or (/shop/basket/@shippinglimitfree &gt; 0 and /shop/page/projector/product/sizes/size/delivery/@limitfree &gt; 0)">
								<span class="projector_shipping__text"><iai:variable vid="Darmowa dostawa"/></span><iaixsl:if test="/shop/basket/@shippinglimitfree &gt; 0 and /shop/basket/@toshippingfree &gt; 0 and /shop/page/projector/product/sizes/size/delivery/@limitfree &gt; 0"><span class="projector_shipping__text_from"> <iai:variable vid="od"/> </span><span class="projector_shipping__price"><iaixsl:value-of select="/shop/basket/@shippinglimitfree_formatted"/></span></iaixsl:if>
							</iaixsl:when>
							<iaixsl:otherwise>
								<iai:variable vid="Tania i szybka dostawa"/>
							</iaixsl:otherwise>
						</iaixsl:choose>
					</a>
				</div>

				<!-- ODBIÓR OSOBISTY -->
				<iaixsl:if test="not(/shop/action/stocks/@available = 'false')">
					<div class="projector_info__item --stocks projector_stocks">
						<span class="projector_stocks__icon projector_info__icon"/>
						<iaixsl:choose>
							<iaixsl:when test="page/projector/product/sizes_version/@stocks_link or page/projector/product/sizes/@stocks_link">
								<a class="projector_stocks__info projector_info__link --link">
									<iaixsl:choose>
										<iaixsl:when test="page/projector/product/sizes_version/@stocks_link">
											<iaixsl:attribute name="href"><iaixsl:value-of select="page/projector/product/sizes_version/@stocks_link"/></iaixsl:attribute>
										</iaixsl:when>
										<iaixsl:otherwise>
											<iaixsl:attribute name="href"><iaixsl:value-of select="page/projector/product/sizes/@stocks_link"/></iaixsl:attribute>
										</iaixsl:otherwise>
									</iaixsl:choose>
									<iai:variable vid="Sprawdź, w którym sklepie obejrzysz i kupisz od ręki"/>
								</a>
							</iaixsl:when>
							<iaixsl:otherwise>
								<span class="projector_stocks__info projector_info__link"><iai:variable vid="Ten produkt nie jest dostępny w sklepie stacjonarnym"/></span>
							</iaixsl:otherwise>
						</iaixsl:choose>
						<iaixsl:if test="page/projector/product/sizes_version/@stocks_link or page/projector/product/sizes/@stocks_link">
							<div id="product_stocks" class="product_stocks">
								<div class="product_stocks__block --product pb-3">
									<div class="product_stocks__product d-flex align-items-center">
										<iaixsl:if test="/shop/page/projector/product/icon">
											<img class="product_stocks__icon mr-4">
												<iaixsl:attribute name="src"><iaixsl:value-of select="/shop/page/projector/product/icon"/></iaixsl:attribute>
												<iaixsl:attribute name="alt"><iaixsl:value-of select="/shop/page/projector/product/name"/></iaixsl:attribute>
											</img>
										</iaixsl:if>
										<div class="product_stocks__details">
											<strong class="product_stocks__name d-block pr-2"><iaixsl:value-of select="/shop/page/projector/product/name"/></strong>
											<iaixsl:if test="(page/projector/product/multiversions) and (count(page/projector/product/multiversions/multi_version) &gt; 1)">
												<div class="product_stocks__versions">
													<iaixsl:for-each select="page/projector/product/multiversions/multi_version">
														<div class="product_stocks__version">
															<span class="product_stocks__version_name"><iaixsl:value-of disable-output-escaping="yes" select="@name"/><![CDATA[:]]></span>
															<span class="product_stocks__version_value">
																<iaixsl:for-each select="item[@selected='true']/values/value">
																	<iaixsl:if test="not(position() = 1)">
																		<![CDATA[ / ]]>
																	</iaixsl:if>
																	<iaixsl:value-of disable-output-escaping="yes" select="@name"/>
																</iaixsl:for-each>
															</span>
														</div>
													</iaixsl:for-each>
												</div>
											</iaixsl:if>
											<iaixsl:if test="(page/projector/product/versions/@count &gt; 0) and (count(page/projector/product/multiversions/multi_version) = 1)">
												<div class="product_stocks__versions">
													<div class="product_stocks__version">
														<span class="product_stocks__version_name"><iaixsl:value-of disable-output-escaping="yes" select="page/projector/product/versions/@name"/><![CDATA[:]]></span>
														<span class="product_stocks__version_value"><iaixsl:value-of disable-output-escaping="yes" select="page/projector/product/versions/version[@id = /shop/page/projector/product/@id]/@name"/></span>
													</div>
												</div>
											</iaixsl:if>
											<div class="product_stocks__sizes row mx-n1">
												<iaixsl:for-each select="/shop/page/projector/product/sizes/size">
													<a class="product_stocks__size select_button col mx-1 mt-2 flex-grow-0 flex-shrink-0">
														<iaixsl:if test="@amount = '0'">
															<iaixsl:attribute name="data-disabled"><![CDATA[true]]></iaixsl:attribute>
														</iaixsl:if>
														<iaixsl:attribute name="href"><![CDATA[#]]><iaixsl:value-of select="@type"/></iaixsl:attribute>
														<iaixsl:attribute name="data-type"><iaixsl:value-of select="@type"/></iaixsl:attribute>
														<iaixsl:value-of select="@description"/>
													</a>
												</iaixsl:for-each>
											</div>
										</div>
									</div>
								</div>
								<div class="product_stocks__block --stocks --skeleton"/>
							</div>
						</iaixsl:if>
					</div>
				</iaixsl:if>

				<!-- SUBSKRYPCJA -->
				<iaixsl:if test="/shop/page/projector/product/subscriptions/subscription">
					<div class="projector_info__item --subscription projector_subscription_info">
						<span class="projector_subscription_info__icon projector_info__icon"/>
						<span class="projector_subscription_info__info projector_info__link"><iai:variable vid="Subskrypcja czyli zakup cykliczny, odnawia się automatycznie"/></span>
					</div>
				</iaixsl:if>

				<!-- SUBSKRYPCJA - PRZERWIJ SUBSKRYPCJĘ  -->
				<iaixsl:if test="/shop/page/projector/product/subscriptions/subscription">
					<div class="projector_info__item --abort-subscription projector_abort_subscription_info">
						<span class="projector_abort_subscription_info__icon projector_info__icon"/>
						<span class="projector_abort_subscription_info__info projector_info__link"><iai:variable vid="Przerwij w dowolnym momencie bez okresu wypowiedzenia"/></span>
					</div>
				</iaixsl:if>

				<!-- RATY -->
				<iaixsl:if test="page/projector/product/payment/instalment">
					<div class="projector_info__item --instalments projector_instalments">
						<span class="projector_instalments__icon projector_info__icon"/>
						<span class="projector_instalments__info projector_info__link"><iai:variable vid="Kup na raty ("/><a class="projector_instalments__link" href="#showInstalments"><iai:variable vid="oblicz ratę"/></a>)</span>
						<div class="projector_instalments__items">
							<iaixsl:for-each select="page/projector/product/payment/instalment">
								<a class="projector_instalments__item">
									<iaixsl:attribute name="data-instalments"><iaixsl:value-of disable-output-escaping="yes" select="@name"/></iaixsl:attribute>
									<iaixsl:attribute name="onclick"><![CDATA[event.stopPropagation(); calculate_instalments(']]><iaixsl:value-of select="@minprice"/><![CDATA[',']]><iaixsl:value-of select="@maxprice"/><![CDATA[',']]><iaixsl:value-of select="@priceTotal"/><![CDATA[',']]><iaixsl:value-of select="@alert"/><![CDATA[',$(this).attr('data-window'),']]><iaixsl:value-of select="@maxquantity"/><![CDATA[',']]><iaixsl:value-of select="@name"/><![CDATA[','',']]><iaixsl:value-of select="@price_type"/><![CDATA['); return false;]]></iaixsl:attribute>
									<iaixsl:attribute name="href"><![CDATA[javascript:]]><iaixsl:value-of select="@calculate"/></iaixsl:attribute>
									<iaixsl:attribute name="data-window"><iaixsl:value-of select="@calculatePrice"/></iaixsl:attribute>
									<iaixsl:if test="@gfx">
										<img class="projector_instalments__item_icon b-lazy" src="/gfx/pol/loader.gif?r=1652092768">
											<iaixsl:attribute name="data-src"><iaixsl:value-of select="@gfx"/></iaixsl:attribute>
											<iaixsl:attribute name="alt"><iaixsl:value-of select="@name"/></iaixsl:attribute>
										</img>
									</iaixsl:if>
									<span class="projector_instalments__item_text"><iaixsl:value-of disable-output-escaping="yes" select="@name"/></span>
								</a>
							</iaixsl:for-each>
						</div>
					</div>
				</iaixsl:if>

				<!-- ODROCZONE PŁATNOŚCI - PAYPO -->
				<iaixsl:if test="/shop/page/projector/product/payment/delayed[@id = '203']">
					<iaixsl:variable name="paypoLiteralWithoutReturns">. <iai:variable vid="Kup teraz, zapłać za 30 dni"/></iaixsl:variable>
					<iaixsl:variable name="paypoLiteral"><iaixsl:choose><iaixsl:when test="not(page/projector/returns_config/@active='y' and not(page/projector/product/@product_type = 'product_virtual' or page/projector/product/@product_type = 'product_service') and $allow_returns_projector = 'true') and not($paypoLiteralWithoutReturns = '')"><iaixsl:value-of select="$paypoLiteralWithoutReturns"/></iaixsl:when><iaixsl:otherwise>. <iai:variable vid="Kup teraz, zapłać za 30 dni, jeżeli nie zwrócisz"/></iaixsl:otherwise></iaixsl:choose></iaixsl:variable>
					<div class="projector_info__item --paypo projector_paypo">
						<span class="projector_paypo__icon projector_info__icon"/>
						<span class="projector_paypo__info projector_info__link"><a class="projector_paypo__link" href="#showPaypo"><iai:variable vid="Odroczone płatności"/></a><iaixsl:value-of select="$paypoLiteral"/></span>
						<div class="paypo_info">
							<h6 class="headline">
								<span class="headline__name"><iai:variable vid="Kup teraz, zapłać później - 4 kroki"/></span>
							</h6>
							<div class="paypo_info__block">
								<div class="paypo_info__item --first">
									<span class="paypo_info__text"><iai:variable vid="Przy wyborze formy płatności, wybierz PayPo"/>.</span>
									<iaixsl:if test="/shop/page/projector/product/payment/delayed[@id = '203']/@gfx">
										<span class="paypo_info__img">
											<img class="b-lazy" src="/gfx/pol/loader.gif?r=1652092768">
												<iaixsl:attribute name="data-src"><iaixsl:value-of select="/shop/page/projector/product/payment/delayed[@id = '203']/@gfx"/></iaixsl:attribute>
												<iaixsl:attribute name="alt"><iaixsl:value-of select="/shop/page/projector/product/payment/delayed[@id = '203']/@name"/></iaixsl:attribute>
											</img>
										</span>
									</iaixsl:if>
								</div>
								<div class="paypo_info__item --second">
									<span class="paypo_info__text"><iai:variable vid="PayPo opłaci twój rachunek w sklepie"/>.<br /><iai:variable vid="Na stronie PayPo sprawdź swoje dane i podaj pesel"/>.</span>
								</div>
								<div class="paypo_info__item --third">
									<span class="paypo_info__text"><iai:variable vid="Po otrzymaniu zakupów decydujesz co ci pasuje, a co nie. Możesz zwrócić część albo całość zamówienia - wtedy zmniejszy się też kwota do zapłaty PayPo"/>.</span>
								</div>
								<div class="paypo_info__item --fourth">
									<span class="paypo_info__text"><iai:variable vid="W ciągu 30 dni od zakupu płacisz PayPo za swoje zakupy"/> <strong><iai:variable vid="bez żadnych dodatkowych kosztów"/></strong>. <iai:variable vid="Jeśli chcesz, rozkładasz swoją płatność na raty"/>.</span>
								</div>
							</div>
						</div>
					</div>
				</iaixsl:if>

				<!-- PUNKTY - PO ZAKUPIE OTRZYMASZ X PKT. -->
				<div class="projector_info__item --points projector_points_recive" id="projector_price_points_recive_wrapper">
					<iaixsl:if test="not(page/projector/product/price/@points_recive and page/projector/product/price/@points_recive &gt; 0)">
						<iaixsl:attribute name="style"><![CDATA[display:none;]]></iaixsl:attribute>
					</iaixsl:if>
					<span class="projector_points_recive__icon projector_info__icon"/>
					<span class="projector_points_recive__info projector_info__link"><span class="projector_points_recive__text"><iai:variable vid="Po zakupie otrzymasz"/> </span><span class="projector_points_recive__value" id="projector_points_recive_points"><iaixsl:value-of select="page/projector/product/price/@points_recive"/> <iai:variable vid="pkt"/>.</span></span>
				</div>
			</div>
		</div>

		<!-- SMILE -->
		<iaixsl:if test="/shop/page/projector/product/smile">
			<div class="projector_smile">
				<div class="projector_smile__block --main">
					<img class="projector_smile__logo b-lazy" src="/gfx/pol/loader.gif?r=1652092768" data-src="/gfx/standards/smile_logo.svg?r=1652092768">
						<iaixsl:attribute name="alt"><iai:variable vid="Kupujesz i dostawę masz gratis!"/></iaixsl:attribute>
					</img>
					<span class="projector_smile__inpost">
						<span class="projector_smile__inpost_text"><iai:variable vid="Darmowa dostawa do paczkomatu"/></span>
						<img class="projector_smile__inpost_logo b-lazy" src="/gfx/pol/loader.gif?r=1652092768" data-src="/gfx/standards/logo_inpost.svg?r=1652092768">
							<iaixsl:attribute name="alt"><iaixsl:value-of select="/shop/page/projector/product/smile/delivery/@name"/></iaixsl:attribute>
						</img>
					</span>
				</div>
				<div class="projector_smile__block --desc">
					<a class="projector_smile__link" href="#more"><iai:variable vid="Więcej informacji"/></a>
				</div>
			</div>
			<div class="smile_info">
				<h6 class="headline">
					<span class="headline__name"><iai:variable vid="Kupujesz i dostawę masz gratis!"/></span>
				</h6>
				<div class="smile_info__item --smile">
					<img class="smile_info__logo b-lazy" src="/gfx/pol/loader.gif?r=1652092768" data-src="/gfx/standards/smile_logo.svg?r=1652092768">
						<iaixsl:attribute name="alt"><iai:variable vid="Kupujesz i dostawę masz gratis!"/></iaixsl:attribute>
					</img>
					<div class="smile_info__sub">
						<span class="smile_info__text">
							<iai:variable vid="dostawy ze sklepów internetowych przy"/>
						</span>
						<strong class="smile_info__strong">
							<iai:variable vid="zamówieniu za"/>
							<span class="smile_info__price"><iaixsl:value-of select="/shop/page/projector/product/smile/delivery/@minprice_formatted"/></span>
								<iai:variable vid="są za darmo"/>.
						</strong>
					</div>
				</div>
				<div class="smile_info__item --inpost">
					<span class="smile_info__text">
						<iai:variable vid="Darmowa dostawa obejmuje dostarczenie przesyłki do paczkomatu"/>
					</span>
					<img class="smile_info__inpost_logo b-lazy" src="/gfx/pol/loader.gif?r=1652092768" data-src="/gfx/standards/logo_inpost.svg?r=1652092768">
						<iaixsl:attribute name="alt"><iaixsl:value-of select="/shop/page/projector/product/smile/delivery/@name"/></iaixsl:attribute>
					</img>
				</div>
				<div class="smile_info__item --footer">
					<span class="smile_info__iai"><iai:variable vid="Smile to usługa IdoSell"/></span>
					<img class="b-lazy" src="/gfx/pol/loader.gif?r=1652092768" data-src="/gfx/standards/smile_info_iai.svg?r=1652092768">
						<iai:variable vid="Smile to usługa IdoSell"/>
					</img>
				</div>
			</div>
		</iaixsl:if>
	</form>

	<script class="ajaxLoad">
		<![CDATA[app_shop.vars.contact_link = "]]><iaixsl:value-of select="/shop/contact/link/@url"/><![CDATA[";]]>
	</script>

	<!--SMARTY -->
	<iaixsl:if test="/shop/@get_ajax_projector_xml"> </iaixsl:if>
	<iaixsl:if test="/shop/page/projector/bookmarklets/item/@icon_small"> </iaixsl:if>
	<iaixsl:if test="/shop/page/projector/product/products_other_founds"> </iaixsl:if>
	<iaixsl:if test="/shop/page/projector/product/payment/instalment/@src"> </iaixsl:if>
<cdata-end/></iai:componentsdata></iai:component>