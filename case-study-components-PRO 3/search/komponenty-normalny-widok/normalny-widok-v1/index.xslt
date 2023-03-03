<?xml version="1.0" encoding="UTF-8"?><iai:component><iai:componentsdata><cdata-start/>
			<!-- SETTINGS -->
			<iaixsl:variable name="show_availability">true</iaixsl:variable>
			<iaixsl:variable name="show_firm">true</iaixsl:variable>
			<iaixsl:variable name="show_label"></iaixsl:variable>
			
			<iaixsl:variable name="param_search">false</iaixsl:variable>
			<iaixsl:variable name="param_search_gfx">false</iaixsl:variable>
			<iaixsl:variable name="versions_search">true</iaixsl:variable>
			<iaixsl:variable name="var_yousave_search">true</iaixsl:variable>
			<iaixsl:variable name="var_net_prices_search"><iaixsl:if test="/shop/page/@price_type = 'net'"><iaixsl:value-of select="$priceTypeText"/></iaixsl:if></iaixsl:variable>
			<iaixsl:variable name="var_gross_prices_search"><iaixsl:if test="/shop/page/@price_type = 'gross'"><iaixsl:value-of select="$priceTypeText"/></iaixsl:if></iaixsl:variable>
			<iaixsl:variable name="var_b2b_search"></iaixsl:variable>
			<!-- TEXTS -->
			<iaixsl:variable name="addcompare_txt">+ <iai:variable vid=" do porównania"/></iaixsl:variable>

			<iaixsl:if test="/shop/page/products/display_mode/@active = 'normal'">
				<section id="search" class="search products d-flex flex-wrap mb-2 mb-sm-3">
					<iaixsl:for-each select="/shop/page/products/product">
						<div class="product col-6 col-sm-4 col-xl-3 pt-3 pb-md-3">
							<iaixsl:attribute name="data-product_id"><iaixsl:value-of select="@id"/></iaixsl:attribute>
							<iaixsl:attribute name="data-product_page"><iaixsl:value-of select="/shop/page/products/navigation/item[@type = 'current']/@counter - 1"/></iaixsl:attribute>
							<iaixsl:if test="position() = 1">
								<iaixsl:attribute name="data-product_first"><![CDATA[true]]></iaixsl:attribute>
							</iaixsl:if>
							<iaixsl:if test="sizes/availability/@status = 'disable'">
								<iaixsl:attribute name="data-product_disable"><![CDATA[true]]></iaixsl:attribute>
							</iaixsl:if>
							<!-- SALESmanago NextGen -->
							<iaixsl:if test="/shop/page/@ecommerce_module_class">
								<iaixsl:attribute name="class">
									product col-6 col-sm-4 py-3

									<iaixsl:variable name="ecommerce_module_separator"><![CDATA[{productId}]]></iaixsl:variable>

									<iaixsl:variable name="ecommerce_module_class_before"><iaixsl:value-of select="substring-before(/shop/page/@ecommerce_module_class, $ecommerce_module_separator)"/></iaixsl:variable>
									<iaixsl:variable name="ecommerce_module_class_after"><iaixsl:value-of select="substring-after(/shop/page/@ecommerce_module_class, $ecommerce_module_separator)"/></iaixsl:variable>

									<iaixsl:value-of select="$ecommerce_module_class_before"/><iaixsl:value-of select="@id"/><iaixsl:value-of select="$ecommerce_module_class_after"/>
								</iaixsl:attribute>
							</iaixsl:if>

							<!-- YOUSAVE -->
							<iaixsl:if test="$var_yousave_search and not($var_yousave_search = '') and price/@yousave_percent != ''">
								<div class="product__yousave">
									<span class="yousave_percent">-<iaixsl:value-of select="price/@yousave_percent"/>%</span>
								</div>
							</iaixsl:if>

							<!-- IKONA PRODUKTU -->
							<a class="product__icon d-flex justify-content-center align-items-center">
								<iaixsl:attribute name="data-product-id"><iaixsl:value-of select="@id"/></iaixsl:attribute>
								<iaixsl:attribute name="href"><iaixsl:value-of select="@link"/></iaixsl:attribute>
								<iaixsl:attribute name="title"><iaixsl:value-of disable-output-escaping="yes" select="name"/></iaixsl:attribute>
								<picture>
									<source>
										<iaixsl:attribute name="media"><![CDATA[(max-width: 420px)]]></iaixsl:attribute>
										<iaixsl:choose>
											<iaixsl:when test="position() &gt; 2">
												<iaixsl:attribute name="data-srcset"><iaixsl:value-of disable-output-escaping="yes" select="icon_small"/></iaixsl:attribute>
											</iaixsl:when>
											<iaixsl:otherwise>
												<iaixsl:attribute name="srcset"><iaixsl:value-of disable-output-escaping="yes" select="icon_small"/></iaixsl:attribute>
											</iaixsl:otherwise>
										</iaixsl:choose>
									</source>
									<img src="/gfx/pol/loader.gif?r=1643713476">
										<iaixsl:attribute name="alt"><iaixsl:value-of disable-output-escaping="yes" select="name"/></iaixsl:attribute>
										<iaixsl:choose>
											<iaixsl:when test="position() &gt; 2">
												<iaixsl:attribute name="class"><![CDATA[b-lazy]]></iaixsl:attribute>
												<iaixsl:attribute name="data-src"><iaixsl:value-of disable-output-escaping="yes" select="icon"/></iaixsl:attribute>
											</iaixsl:when>
											<iaixsl:otherwise>
												<iaixsl:attribute name="src"><iaixsl:value-of disable-output-escaping="yes" select="icon"/></iaixsl:attribute>
											</iaixsl:otherwise>
										</iaixsl:choose>
									</img>
								</picture>

								<!-- LABEL -->
								<iaixsl:if test="$show_label">
  								<iaixsl:variable name="productUnavailable"><iai:variable vid="Chwilowo niedostępny"/></iaixsl:variable>
  								<iaixsl:choose>
  									<iaixsl:when test="not($productUnavailable = '') and sizes/availability/@status = 'disable'">
  										<strong class="label_icons">
  											<span class="label --disable">
  												<iaixsl:value-of select="$productUnavailable"/>
  											</span>
  										</strong>
  									</iaixsl:when>
  									<iaixsl:when test="@promo or @new or @bestseller or @discount or (@distinguished and not(@bestseller and @discount))">
  										<strong class="label_icons">
  											<iaixsl:if test="@promo">
  												<span class="label --promo">
  													<iai:variable vid="W promocji"/>
  												</span>
  											</iaixsl:if>
  											<iaixsl:if test="@new">
  												<span class="label --new">
  													<iai:variable vid="Nowość"/>
  												</span>
  											</iaixsl:if>
  											<iaixsl:choose>
  												<iaixsl:when test="@promo and @new">
  												</iaixsl:when>
  												<iaixsl:when test="@promo or @new">
  													<iaixsl:choose>
  														<iaixsl:when test="@bestseller">
  															<span class="label --bestseller">
  																<iai:variable vid="Nasz bestseller"/>
  															</span>
  														</iaixsl:when>
  														<iaixsl:when test="@discount">
  															<span class="label --discount">
  																<iai:variable vid="Przecena"/>
  															</span>
  														</iaixsl:when>
  														<iaixsl:when test="@distinguished">
  															<span class="label --distinguished">
  																<iai:variable vid="Polecany"/>
  															</span>
  														</iaixsl:when>
  													</iaixsl:choose>
  												</iaixsl:when>
  												<iaixsl:otherwise>
  													<iaixsl:if test="@bestseller">
  														<span class="label --bestseller">
  															<iai:variable vid="Nasz bestseller"/>
  														</span>
  													</iaixsl:if>
  													<iaixsl:if test="@discount">
  														<span class="label --discount">
  															<iai:variable vid="Przecena"/>
  														</span>
  													</iaixsl:if>
  													<iaixsl:if test="@distinguished and not(@bestseller and @discount)">
  														<span class="label --distinguished">
  															<iai:variable vid="Polecany"/>
  														</span>
  													</iaixsl:if>
  												</iaixsl:otherwise>
  											</iaixsl:choose>
  										</strong>
  									</iaixsl:when>
  								</iaixsl:choose>
								</iaixsl:if>
							</a>
              
              <!-- PRODUCENT / MARKA -->
              <iaixsl:if test="firm and $show_firm">
                <div class="product__firm">
                  <iaixsl:choose>
                    <iaixsl:when test="firm/@productslink">
                      <a class="firm_name --link">
    										<iaixsl:attribute name="title"><iaixsl:value-of select="firm/@name"/></iaixsl:attribute>
    										<iaixsl:attribute name="href"><iaixsl:value-of select="firm/@productslink"/></iaixsl:attribute>
    										<iaixsl:value-of select="firm/@name"/>
                      </a>
                    </iaixsl:when>
                    <iaixsl:otherwise> 
                      <span class="firm_name"><iaixsl:value-of select="firm/@name"/></span>
                    </iaixsl:otherwise>
                  </iaixsl:choose>
                </div>
              </iaixsl:if>

							<!-- NAZWA PRODUKTU -->
							<h3>
								<a class="product__name">
									<iaixsl:attribute name="href"><iaixsl:value-of select="@link"/></iaixsl:attribute>
									<iaixsl:attribute name="title"><iaixsl:value-of disable-output-escaping="yes" select="name"/></iaixsl:attribute>
									<iaixsl:value-of disable-output-escaping="yes" select="name"/>
								</a>
							</h3>

              <!-- DOSTĘPNOŚĆ -->
              <iaixsl:if test="sizes/availability and $show_availability">
                <div class="product__availability d-flex align-items-center mb-3">
                  <iaixsl:if test="sizes/availability/@status_gfx">
                    <img class="status_gfx">
  										<iaixsl:attribute name="alt"><iaixsl:value-of select="sizes/availability/@status_description"/></iaixsl:attribute>
  										<iaixsl:attribute name="src"><iaixsl:value-of select="sizes/availability/@status_gfx"/></iaixsl:attribute>
                    </img>
                  </iaixsl:if>
                  <iaixsl:if test="sizes/availability/@status_description">
                    <span class="status_description">
                      <iaixsl:value-of select="sizes/availability/@status_description"/>
                    </span>
                  </iaixsl:if>
                </div>
              </iaixsl:if>
      
							<!-- CENA -->
							<iaixsl:choose>
								<!-- Cena netto -->
								<iaixsl:when test="$var_net_prices_search and not($var_net_prices_search = '')">
									<div class="product__prices">
										<iaixsl:choose>
											<iaixsl:when test="(sizes/prices/@minprice_net_formatted != sizes/prices/@maxprice_net_formatted) or (sizes/prices/@minprice_unit_formatted != sizes/prices/@maxprice_unit_formatted)">
												<iaixsl:if test="(sizes/prices/@size_min_maxprice_net_formatted != sizes/prices/@size_max_maxprice_net_formatted) or (sizes/prices/@size_min_maxprice_unit_formatted != sizes/prices/@size_max_maxprice_unit_formatted)">
													<del class="price --max">
														<iaixsl:choose>
															<iaixsl:when test="sizes/prices/@size_min_maxprice_unit_formatted">
																<span><iaixsl:value-of select="sizes/prices/@size_min_maxprice_unit_formatted"/></span><b> - </b><span><iaixsl:value-of select="sizes/prices/@size_max_maxprice_unit_formatted"/></span><span class="price_vat"><iaixsl:value-of select="$var_net_prices_search"/></span>
															</iaixsl:when>
															<iaixsl:otherwise>
																<span><iaixsl:value-of select="sizes/prices/@size_min_maxprice_net_formatted"/></span><b> - </b><span><iaixsl:value-of select="sizes/prices/@size_max_maxprice_net_formatted"/></span><span class="price_vat"><iaixsl:value-of select="$var_net_prices_search"/></span>
															</iaixsl:otherwise>
														</iaixsl:choose>
													</del>
												</iaixsl:if>
												<strong class="price">
													
													<iaixsl:choose>
														<iaixsl:when test="sizes/prices/@minprice_unit_formatted">
															<iaixsl:value-of select="sizes/prices/@minprice_unit_formatted"/>
														</iaixsl:when>
														<iaixsl:otherwise>
															<iaixsl:value-of select="sizes/prices/@minprice_net_formatted"/>
														</iaixsl:otherwise>
													</iaixsl:choose>
													 - 
													<iaixsl:choose>
														<iaixsl:when test="sizes/prices/@maxprice_unit_formatted">
															<iaixsl:value-of select="sizes/prices/@maxprice_unit_formatted"/>
														</iaixsl:when>
														<iaixsl:otherwise>
															<iaixsl:value-of select="sizes/prices/@maxprice_net_formatted"/>
														</iaixsl:otherwise>
													</iaixsl:choose>

													<iaixsl:if test="sizes/prices/@minprice_unit_formatted">
														<iaixsl:text><![CDATA[ / ]]></iaixsl:text><iaixsl:value-of select="sizes/@unit_sellby"/><iaixsl:text> </iaixsl:text><iaixsl:value-of select="sizes/@unit"/>
													</iaixsl:if>
													<span class="price_vat"><iaixsl:value-of select="$var_net_prices_search"/></span>
												</strong>
											</iaixsl:when>
											<iaixsl:when test="price/@price_net = 0 and not(/shop/basket/@wholesaler = 'true') and $var_b2b_search and not($var_b2b_search = '')">
												<a class="price --hurt">
													<iaixsl:attribute name="title"><iaixsl:value-of select="$var_b2b_search"/></iaixsl:attribute>
													<iaixsl:attribute name="href"><iaixsl:value-of select="/shop/action/signin/@url"/></iaixsl:attribute>
													<iaixsl:value-of select="$var_b2b_search"/>
												</a>
											</iaixsl:when>

											<iaixsl:when test="(sizes/prices/@minprice_net = 0) and not(price/@points)">
												<a class="price --phone">
													<iaixsl:attribute name="title"><iai:variable vid="Kliknij, by przejść do formularza kontaktu"/></iaixsl:attribute>
													<iaixsl:attribute name="href"><iaixsl:value-of select="/shop/action/contact/@url"/></iaixsl:attribute>
													<iai:variable vid="Cena na telefon"/>
												</a>
											</iaixsl:when>
											<iaixsl:otherwise>
												<iaixsl:if test="price/@maxprice_net or price/@maxprice_unit">
													<del class="price --max">
														
														<iaixsl:choose>
															<iaixsl:when test="price/@maxprice_unit_formatted">
																<iaixsl:value-of select="price/@maxprice_unit_formatted"/><span class="price_vat"><iaixsl:value-of select="$var_net_prices_search"/></span>
															</iaixsl:when>
															<iaixsl:otherwise>
																<iaixsl:value-of select="price/@maxprice_net_formatted"/><span class="price_vat"><iaixsl:value-of select="$var_net_prices_search"/></span>
															</iaixsl:otherwise>
														</iaixsl:choose>
													</del>
												</iaixsl:if>
												<strong class="price">
													<iaixsl:choose>
														<iaixsl:when test="price/@price_unit_net_formatted">
															<iaixsl:value-of select="price/@price_unit_net_formatted"/><iaixsl:text><![CDATA[ / ]]></iaixsl:text><iaixsl:value-of select="sizes/@unit_sellby"/><iaixsl:text> </iaixsl:text><iaixsl:value-of select="sizes/@unit"/>
														</iaixsl:when>
														<iaixsl:otherwise>
															<iaixsl:value-of select="price/@price_net_formatted"/>
														</iaixsl:otherwise>
													</iaixsl:choose>
													<span class="price_vat"><iaixsl:value-of select="$var_net_prices_search"/></span>
												</strong>

												<iaixsl:if test="price/@points">
													<span class="price --points"><iaixsl:value-of select="price/@points"/><span class="currency"> <iai:variable vid="PKT"/></span></span>
												</iaixsl:if>
											</iaixsl:otherwise>
										</iaixsl:choose>

										<!-- CENA ZA KILO -->
										<iaixsl:if test="price/@unit_converted_price_net_formatted"><small class="price --convert"><iaixsl:value-of select="price/@unit_converted_price_net_formatted"/><iaixsl:text><![CDATA[ / ]]></iaixsl:text><iaixsl:value-of select="price/@unit_converted_format"/><span class="price_vat"><iaixsl:value-of select="$var_net_prices_search"/></span></small>
										</iaixsl:if>
									</div>
								</iaixsl:when>
								<!-- Cena detaliczna -->
								<iaixsl:otherwise>
									<div class="product__prices">
										<iaixsl:choose>
											<iaixsl:when test="(sizes/prices/@minprice_formatted != sizes/prices/@maxprice_formatted) or (sizes/prices/@minprice_unit_formatted != sizes/prices/@maxprice_unit_formatted)">
												<iaixsl:if test="(sizes/prices/@size_min_maxprice_formatted != sizes/prices/@size_max_maxprice_formatted) or (sizes/prices/@size_min_maxprice_unit_formatted != sizes/prices/@size_max_maxprice_unit_formatted)">
													<del class="price --max">
														<iaixsl:choose>
															<iaixsl:when test="sizes/prices/@size_min_maxprice_unit_formatted">
																<span><iaixsl:value-of select="sizes/prices/@size_min_maxprice_unit_formatted"/></span><b> - </b><span><iaixsl:value-of select="sizes/prices/@size_max_maxprice_unit_formatted"/></span><span class="price_vat"><iaixsl:value-of select="$var_gross_prices_search"/></span>
															</iaixsl:when>
															<iaixsl:otherwise>
																<span><iaixsl:value-of select="sizes/prices/@size_min_maxprice_formatted"/></span><b> - </b><span><iaixsl:value-of select="sizes/prices/@size_max_maxprice_formatted"/></span><span class="price_vat"><iaixsl:value-of select="$var_gross_prices_search"/></span>
															</iaixsl:otherwise>
														</iaixsl:choose>
													</del>
												</iaixsl:if>
												<strong class="price">
													
													<iaixsl:choose>
														<iaixsl:when test="sizes/prices/@minprice_unit_formatted">
															<iaixsl:value-of select="sizes/prices/@minprice_unit_formatted"/>
														</iaixsl:when>
														<iaixsl:otherwise>
															<iaixsl:value-of select="sizes/prices/@minprice_formatted"/>
														</iaixsl:otherwise>
													</iaixsl:choose>
													 - 
													<iaixsl:choose>
														<iaixsl:when test="sizes/prices/@maxprice_unit_formatted">
															<iaixsl:value-of select="sizes/prices/@maxprice_unit_formatted"/>
														</iaixsl:when>
														<iaixsl:otherwise>
															<iaixsl:value-of select="sizes/prices/@maxprice_formatted"/>
														</iaixsl:otherwise>
													</iaixsl:choose>

													<iaixsl:if test="sizes/prices/@minprice_unit_formatted">
														<iaixsl:text><![CDATA[ / ]]></iaixsl:text><iaixsl:value-of select="sizes/@unit_sellby"/><iaixsl:text> </iaixsl:text><iaixsl:value-of select="sizes/@unit"/>
													</iaixsl:if>
													<span class="price_vat"><iaixsl:value-of select="$var_gross_prices_search"/></span>
												</strong>
											</iaixsl:when>

											<iaixsl:when test="(sizes/prices/@minprice = 0) and not(price/@points)">
												<a class="price --phone">
													<iaixsl:attribute name="title"><iai:variable vid="Kliknij, by przejść do formularza kontaktu"/></iaixsl:attribute>
													<iaixsl:attribute name="href"><iaixsl:value-of select="/shop/action/contact/@url"/></iaixsl:attribute>
													<iai:variable vid="Cena na telefon"/>
												</a>
											</iaixsl:when>
											<iaixsl:otherwise>
												<iaixsl:if test="price/@maxprice or price/@maxprice_unit">
													<del class="price --max">
														
														<iaixsl:choose>
															<iaixsl:when test="price/@maxprice_unit_formatted">
																<iaixsl:value-of select="price/@maxprice_unit_formatted"/><span class="price_vat"><iaixsl:value-of select="$var_gross_prices_search"/></span>
															</iaixsl:when>
															<iaixsl:otherwise>
																<iaixsl:value-of select="price/@maxprice_formatted"/><span class="price_vat"><iaixsl:value-of select="$var_gross_prices_search"/></span>
															</iaixsl:otherwise>
														</iaixsl:choose>
													</del>
												</iaixsl:if>
												<strong class="price">
													<iaixsl:choose>
														<iaixsl:when test="price/@price_unit_formatted">
															<iaixsl:value-of select="price/@price_unit_formatted"/><iaixsl:text><![CDATA[ / ]]></iaixsl:text><iaixsl:value-of select="sizes/@unit_sellby"/><iaixsl:text> </iaixsl:text><iaixsl:value-of select="sizes/@unit"/>
														</iaixsl:when>
														<iaixsl:otherwise>
															<iaixsl:value-of select="sizes/prices/@minprice_formatted"/>
															<span class="price__unit"><iaixsl:text><![CDATA[ / ]]></iaixsl:text><iaixsl:value-of select="sizes/@unit"/></span>
														</iaixsl:otherwise>
													</iaixsl:choose>
													<span class="price_vat"><iaixsl:value-of select="$var_gross_prices_search"/></span>
												</strong>

												<iaixsl:if test="price/@points">
													<span class="price --points"><iaixsl:value-of select="price/@points"/><span class="currency"> <iai:variable vid="PKT"/></span></span>
												</iaixsl:if>
											</iaixsl:otherwise>
										</iaixsl:choose>

										<!-- CENA ZA KILO -->
										<iaixsl:if test="price/@unit_converted_price_formatted"><small class="price --convert"><iaixsl:value-of select="price/@unit_converted_price_formatted"/><iaixsl:text><![CDATA[ / ]]></iaixsl:text><iaixsl:value-of select="price/@unit_converted_format"/><span class="price_vat"><iaixsl:value-of select="$var_gross_prices_search"/></span></small>
										</iaixsl:if>
									</div>
								</iaixsl:otherwise>
							</iaixsl:choose>

							<!-- DO PORÓWNANIA -->
							<div class="product__compare">
								<iaixsl:if test="/shop/compare/@active = 'y' and $addcompare_txt">
									<iaixsl:attribute name="class"><![CDATA[product__compare --has-child]]></iaixsl:attribute>

									<iaixsl:choose>
										<iaixsl:when test="@id = /shop/compare/product/@id">
											<a class="product__compare_item --remove btn" rel="nofollow">
												<iaixsl:attribute name="href"><iaixsl:choose><iaixsl:when test="/shop/action/settings/@url"><iaixsl:value-of select="/shop/action/settings/@url"/></iaixsl:when><iaixsl:otherwise><![CDATA[settings.php]]></iaixsl:otherwise></iaixsl:choose><![CDATA[?comparers=remove&amp;product=]]><iaixsl:value-of select="@id"/></iaixsl:attribute>
												<iaixsl:attribute name="title"><iai:variable vid="Kliknij, aby usunąć produkt z porównywarki"/></iaixsl:attribute>
												- <iai:variable vid=" z porównania"/>
											</a>
										</iaixsl:when>
										<iaixsl:otherwise>
											<a class="product__compare_item --add btn" rel="nofollow">
												<iaixsl:attribute name="href"><iaixsl:choose><iaixsl:when test="/shop/action/settings/@url"><iaixsl:value-of select="/shop/action/settings/@url"/></iaixsl:when><iaixsl:otherwise><![CDATA[settings.php]]></iaixsl:otherwise></iaixsl:choose><![CDATA[?comparers=add&amp;product=]]><iaixsl:value-of select="@id"/></iaixsl:attribute>
												<iaixsl:attribute name="title"><iai:variable vid="Kliknij, aby dodać produkt do porównania"/></iaixsl:attribute>
												<iaixsl:value-of select="$addcompare_txt"/>
											</a>
										</iaixsl:otherwise>
									</iaixsl:choose>
								</iaixsl:if>
							</div>

							<!-- WARIANTY I ROZMIARY -->
							<iaixsl:if test="not($versions_search)">
								<iaixsl:if test="(count(versions/version[@gfx_small]) &gt; 1 and count(versions/version) = count(versions/version[@gfx_small])) or (sizes/size/@type and not(sizes/size/@type='uniw'))">
										<div class="product__details py-1 px-3">
												<iaixsl:if test="sizes/size/@type and not(sizes/size/@type='uniw')">
														<div class="product__sizes mb-1">
																<label class="product__size --label"><iai:variable vid="Rozmiar"/>:</label>
																<iaixsl:for-each select="sizes/size">
																		<span class="product__size"><iaixsl:value-of select="@description"/></span>
																</iaixsl:for-each>
														</div>
												</iaixsl:if>

												<iaixsl:if test="count(versions/version/@gfx_small) &gt; 1">
														<div class="product__versions mx-n1">
																<iaixsl:for-each select="versions/version">
																		<a class="product__version">
																				<iaixsl:attribute name="href"><iaixsl:value-of select="@link"/></iaixsl:attribute>
																				<img>
																						<iaixsl:attribute name="src"><iaixsl:value-of select="@gfx_small"/></iaixsl:attribute>
																						<iaixsl:attribute name="alt"><iaixsl:value-of select="@name"/></iaixsl:attribute>
																				</img>
																		</a>
																</iaixsl:for-each>
														</div>
												</iaixsl:if>
										</div>
								</iaixsl:if>
							</iaixsl:if>

							<!-- PARAMETRY -->
							<iaixsl:if test="not($param_search)">
								<iaixsl:if test="traits/trait[not(@gfx)] and traits/trait[not(contains(@groupdescription, 'gs1:'))]">
									<div class="product__traits d-none d-md-block mt-2">
										<ul>
											<iaixsl:for-each select="traits/trait[not(@gfx)]">
												<iaixsl:if test="not(@groupid = preceding-sibling::trait/@groupid) and not(contains(@groupdescription, 'gs1:'))">
													<li class="trait">
														<span class="trait__name"><iaixsl:value-of select="@groupdescription"/>: </span>
														<div class="trait__values">
															<a class="trait__value"><iaixsl:attribute name="href"><iaixsl:value-of select="@link"/></iaixsl:attribute><iaixsl:value-of select="@traitdescription"/></a>
															<iaixsl:if test="@groupid = following-sibling::trait/@groupid">
																<iaixsl:variable name="temporaryGroup"><iaixsl:value-of select="@groupid"/></iaixsl:variable><iaixsl:for-each select="following-sibling::trait[(@groupid = $temporaryGroup)]">, <a class="trait__value"><iaixsl:attribute name="href"><iaixsl:value-of select="@link"/></iaixsl:attribute><iaixsl:value-of select="@traitdescription"/></a></iaixsl:for-each>
															</iaixsl:if>
														</div>
													</li>
												</iaixsl:if>
											</iaixsl:for-each>
										</ul>
									</div>
								</iaixsl:if>
							</iaixsl:if>

							<!-- PARAMETRY GRAFICZNY -->
							<iaixsl:if test="not($param_search_gfx)">
								<iaixsl:if test="traits/trait[@gfx2]">
									<div class="product__traits --gfx my-2 mb-md-0">
										<ul>
											<iaixsl:for-each select="traits/trait[@gfx2]">
												<li class="trait">
													<a class="trait__gfx">
														<iaixsl:attribute name="title"><iaixsl:value-of select="@groupdescription"/><iaixsl:text> </iaixsl:text><iaixsl:value-of select="@traitdescription"/></iaixsl:attribute>
														<iaixsl:attribute name="href"><iaixsl:value-of select="@link"/></iaixsl:attribute>
														<img class="trait__img">
															<iaixsl:attribute name="src"><iaixsl:value-of select="@gfx2"/></iaixsl:attribute>
															<iaixsl:attribute name="alt"><iaixsl:value-of select="@traitdescription"/></iaixsl:attribute>
														</img>
													</a>
												</li>
											</iaixsl:for-each>
										</ul>
									</div>
								</iaixsl:if>
							</iaixsl:if>
						</div>
					</iaixsl:for-each>
				</section>
			</iaixsl:if>
			<iaixsl:if test="/shop/page/search_params/*"> </iaixsl:if>
		<cdata-end/></iai:componentsdata></iai:component>