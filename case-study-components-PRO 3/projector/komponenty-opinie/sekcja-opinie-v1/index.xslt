<?xml version="1.0" encoding="UTF-8"?><iai:component><iai:componentsdata><cdata-start/>
	<section id="opinions_section" class="row mb-4 mx-n3 mb-md-8">
		<iaixsl:variable name="count_opinions">3</iaixsl:variable>
		<iaixsl:variable name="more_opinions"><iai:variable vid="Zobacz więcej"/></iaixsl:variable>

		<iaixsl:if test="/shop/page/projector/comments/@all &gt; '0'">
			<div class="col-12">
				<h2 class="headline">
					<span class="headline__name"><iai:variable vid="Opinie" /></span>
				</h2>
			</div>
			<div class="average_opinions_container col-12 mb-4 mb-md-8">
				<div class="row flex-md-row average_opinions__sub">
					<div class="col-12 col-sm-6 col-md-4 col-lg-3 average_opinions__item">
						<div class="average_opinions_box">
							<div class="comments">
								<div class="note">
									<span>
										<i class="icon-star">
											<iaixsl:if test="page/projector/comments/@avg &gt; 0.5"><iaixsl:attribute name="class"><![CDATA[icon-star active]]></iaixsl:attribute></iaixsl:if>
										</i>
										<i class="icon-star">
											<iaixsl:if test="page/projector/comments/@avg &gt; 1.5"><iaixsl:attribute name="class"><![CDATA[icon-star active]]></iaixsl:attribute></iaixsl:if>
										</i>
										<i class="icon-star">
											<iaixsl:if test="page/projector/comments/@avg &gt; 2.5"><iaixsl:attribute name="class"><![CDATA[icon-star active]]></iaixsl:attribute></iaixsl:if>
										</i>
										<i class="icon-star">
											<iaixsl:if test="page/projector/comments/@avg &gt; 3.5"><iaixsl:attribute name="class"><![CDATA[icon-star active]]></iaixsl:attribute></iaixsl:if>
										</i>
										<i class="icon-star">
											<iaixsl:if test="page/projector/comments/@avg &gt; 4.5"><iaixsl:attribute name="class"><![CDATA[icon-star active]]></iaixsl:attribute></iaixsl:if>
										</i>
									</span>
								</div>
							</div>
							<div class="average_opinions_score">
								<iaixsl:value-of disable-output-escaping="yes" select="page/projector/comments/@avg"/>
							</div>
							<div class="average_opinions_desc d-none">
								<iai:variable vid="Liczba wystawionych opinii"/>: <iaixsl:value-of select="page/projector/comments/@all"/>
							</div>
						</div>
						<div class="opinions_add">
							<iaixsl:choose>
								<iaixsl:when test="(page/projector/comments/opinionClient/opinion/@stat = 'y')">
									<div class="opinions_avg_info menu_messages_message small">
										<iai:variable vid="Twoja opinia jest już zatwierdzona. Nie możesz dodać więcej opinii do tego produktu"/>.
									</div>
								</iaixsl:when>
								<iaixsl:otherwise>
									<iaixsl:if test="(page/projector/comments/opinionClient/opinion/@stat = 'n')">
										<div class="opinions_avg_info menu_messages_message small">
												<iai:variable vid="Przed opublikowaniem Twoja opinia zostanie sprawdzona pod względem obyczajowym"/>.
										</div>
									</iaixsl:if>
									<a href="#showOpinionForm" id="show_opinion_form" class="btn --solid --medium">
										<iaixsl:choose>
											<iaixsl:when test="(page/projector/comments/opinionClient/opinion/@stat = 'n')">
												<iai:variable vid="Zmień swoją opinię"/>
											</iaixsl:when>
											<iaixsl:otherwise>
												<iai:variable vid="Napisz swoją opinię"/>
											</iaixsl:otherwise>
										</iaixsl:choose>
									</a>
									<iaixsl:if test="/shop/page/projector/comments/opinionClient/@points">
										<div class="opinions_affiliate_points">
											<iaixsl:choose>
												<iaixsl:when test="/shop/page/projector/comments/opinionClient/image/@points">
													<iai:variable vid="Za opinię ze zdjęciem otrzymasz"/>
												</iaixsl:when>
												<iaixsl:otherwise>
													<iai:variable vid="Za opinię otrzymasz"/>
												</iaixsl:otherwise>
											</iaixsl:choose>
											<strong>
												<iaixsl:choose>
													<iaixsl:when test="substring-after(/shop/page/projector/comments/opinionClient/@points, '.') = '00'">
														<iaixsl:value-of select="substring-before(/shop/page/projector/comments/opinionClient/@points, '.')"/>
													</iaixsl:when>
													<iaixsl:otherwise>
														<iaixsl:value-of select="/shop/page/projector/comments/opinionClient/@points"/>
													</iaixsl:otherwise>
												</iaixsl:choose>

												<iaixsl:text> </iaixsl:text><iai:variable vid="pkt"/>.</strong>
											<br/><iai:variable vid="w naszym programie lojalnościowym"/>.
										</div>
									</iaixsl:if>
								</iaixsl:otherwise>
							</iaixsl:choose>
						</div>
					</div>


					<iaixsl:variable name="totalOpinionsAll"><iaixsl:value-of select="page/projector/comments/@all"/></iaixsl:variable>
					<div class="col-12 col-sm-6 col-md-4 col-lg-3 average_opinions__item">
						<iaixsl:if test="/shop/page/projector/comments/opinions/opinion[@confirmedByPurchase = 'true']">
							<div class="opinions_filter_confirmed f-group --checkbox">
								<input type="checkbox" class="f-control" id="opinions_filter_confirmed"/>
								<label class="f-label" for="opinions_filter_confirmed"><iai:variable vid="Pokaż tylko opinie potwierdzone zakupem"/></label>
							</div>
						</iaixsl:if>
						<div class="average_opinions_list">
							<div class="opinion_rate" id="shop-opinion_rate_5">
								<span class="opinion_number"><![CDATA[5]]></span><span class="opinion_number_star"><i class="icon-star"> </i></span>
								<div class="opinions_bar_container">
									<div class="opinions_bar_active">
										<iaixsl:variable name="total5"><iaixsl:value-of select="count(/shop/page/projector/comments/opinions/opinion[@note='5'])"/></iaixsl:variable>
										<iaixsl:attribute name="style"><![CDATA[width: ]]><iaixsl:value-of select="$total5 div $totalOpinionsAll * 100"/><![CDATA[%]]></iaixsl:attribute>
									</div>
								</div>
								<span class="rate_count">(<iaixsl:value-of select="count(page/projector/comments/opinions/opinion[@note='5'])"/>)</span>
							</div>
							<div class="opinion_rate" id="shop-opinion_rate_4">
								<span class="opinion_number"><![CDATA[4]]></span><span class="opinion_number_star"><i class="icon-star"> </i></span>
								<div class="opinions_bar_container">
									<div class="opinions_bar_active">
										<iaixsl:variable name="total4"><iaixsl:value-of select="count(/shop/page/projector/comments/opinions/opinion[@note='4'])"/></iaixsl:variable>
										<iaixsl:attribute name="style"><![CDATA[width: ]]><iaixsl:value-of select="$total4 div $totalOpinionsAll * 100"/><![CDATA[%]]></iaixsl:attribute>
									</div>
								</div>
								<span class="rate_count">(<iaixsl:value-of select="count(page/projector/comments/opinions/opinion[@note='4'])"/>)</span>
							</div>
							<div class="opinion_rate" id="shop-opinion_rate_3">
								<span class="opinion_number"><![CDATA[3]]></span><span class="opinion_number_star"><i class="icon-star"> </i></span>
								<div class="opinions_bar_container">
									<div class="opinions_bar_active">
										<iaixsl:variable name="total3"><iaixsl:value-of select="count(/shop/page/projector/comments/opinions/opinion[@note='3'])"/></iaixsl:variable>
										<iaixsl:attribute name="style"><![CDATA[width: ]]><iaixsl:value-of select="$total3 div $totalOpinionsAll * 100"/><![CDATA[%]]></iaixsl:attribute>
									</div>
								</div>
								<span class="rate_count">(<iaixsl:value-of select="count(page/projector/comments/opinions/opinion[@note='3'])"/>)</span>
							</div>
							<div class="opinion_rate" id="shop-opinion_rate_2">
								<span class="opinion_number"><![CDATA[2]]></span><span class="opinion_number_star"><i class="icon-star"> </i></span>
								<div class="opinions_bar_container">
									<div class="opinions_bar_active">
										<iaixsl:variable name="total2"><iaixsl:value-of select="count(/shop/page/projector/comments/opinions/opinion[@note='2'])"/></iaixsl:variable>
										<iaixsl:attribute name="style"><![CDATA[width: ]]><iaixsl:value-of select="$total2 div $totalOpinionsAll * 100"/><![CDATA[%]]></iaixsl:attribute>
									</div>
								</div>
								<span class="rate_count">(<iaixsl:value-of select="count(page/projector/comments/opinions/opinion[@note='2'])"/>)</span>
							</div>
							<div class="opinion_rate" id="shop-opinion_rate_1">
								<span class="opinion_number"><![CDATA[1]]></span><span class="opinion_number_star"><i class="icon-star"> </i></span>
								<div class="opinions_bar_container">
									<div class="opinions_bar_active">
										<iaixsl:variable name="total1"><iaixsl:value-of select="count(/shop/page/projector/comments/opinions/opinion[@note='1'])"/></iaixsl:variable>
										<iaixsl:attribute name="style"><![CDATA[width: ]]><iaixsl:value-of select="$total1 div $totalOpinionsAll * 100"/><![CDATA[%]]></iaixsl:attribute>
									</div>
								</div>
								<span class="rate_count">(<iaixsl:value-of select="count(page/projector/comments/opinions/opinion[@note='1'])"/>)</span>
							</div>
						</div>
						<div class="opinions-shop_guide d-none">
							<iai:variable vid="Kliknij ocenę aby filtrować opinie"/>
						</div>
					</div>
				</div>
			</div>

			<!-- Ilość opinii i średnia ocena -->
			<div class="opinions_list col-12">
				<div class="row justify-content-sm-center">
					<iaixsl:for-each select="/shop/page/projector/comments/opinions/opinion">
						<div class="opinions_list__item col-12 col-sm-6 col-md-4">
							<iaixsl:choose>
								<iaixsl:when test="@note &gt; 4.5"><iaixsl:attribute name="data-opinion_rate"><![CDATA[shop-opinion_rate_5]]></iaixsl:attribute></iaixsl:when>
								<iaixsl:when test="@note &gt; 3.5"><iaixsl:attribute name="data-opinion_rate"><![CDATA[shop-opinion_rate_4]]></iaixsl:attribute></iaixsl:when>
								<iaixsl:when test="@note &gt; 2.5"><iaixsl:attribute name="data-opinion_rate"><![CDATA[shop-opinion_rate_3]]></iaixsl:attribute></iaixsl:when>
								<iaixsl:when test="@note &gt; 1.5"><iaixsl:attribute name="data-opinion_rate"><![CDATA[shop-opinion_rate_2]]></iaixsl:attribute></iaixsl:when>
								<iaixsl:when test="@note &gt; 0.5"><iaixsl:attribute name="data-opinion_rate"><![CDATA[shop-opinion_rate_1]]></iaixsl:attribute></iaixsl:when>
							</iaixsl:choose>
							<iaixsl:if test="position() &gt; $count_opinions">
								<iaixsl:attribute name="data-hide"><![CDATA[true]]></iaixsl:attribute>
							</iaixsl:if>
							<iaixsl:attribute name="data-confirmed" ><iaixsl:value-of select="@confirmedByPurchase" /></iaixsl:attribute>
							<div class="opinions_element_holder d-flex mb-4 pb-4 align-items-start">
								<iaixsl:if test="@image_small and not(@image_small = '')">
									<div class="opinions_element_photo">
										<a data-imagelightbox="o" target="_blank">
											<iaixsl:attribute name="href"><iaixsl:value-of select="@image_large"/></iaixsl:attribute>
											<!-- <iaixsl:attribute name="style"><![CDATA[background-image: url(']]><iaixsl:value-of select="@image_small"/><![CDATA[');]]></iaixsl:attribute> -->

											<img class="b-lazy" src="/gfx/pol/loader.gif?r=1652092768">
												<iaixsl:attribute name="width" ><iaixsl:value-of select="@width_large" /></iaixsl:attribute>
												<iaixsl:attribute name="height" ><iaixsl:value-of select="@height_large" /></iaixsl:attribute>
												<iaixsl:attribute name="alt"><iaixsl:value-of select="@client"/></iaixsl:attribute>
												<iaixsl:attribute name="title"><iaixsl:value-of select="@client"/></iaixsl:attribute>
												<iaixsl:attribute name="data-src"><iaixsl:value-of select="@image_large"/></iaixsl:attribute>
											</img>
										</a>
									</div>
								</iaixsl:if>
								<div class="opinions_element">
									<!-- OPINIE TOP -->
									<div class="opinions_element_top">
										<!-- OCENA OPINII -->
										<iaixsl:if test="(@note)">
											<div class="opinions_element_stars">
												<div class="note">
													<span>
														<i class="icon-star">
															<iaixsl:if test="@note &gt; 0.5"><iaixsl:attribute name="class"><![CDATA[icon-star active]]></iaixsl:attribute></iaixsl:if>
														</i>
														<i class="icon-star">
															<iaixsl:if test="@note &gt; 1.5"><iaixsl:attribute name="class"><![CDATA[icon-star active]]></iaixsl:attribute></iaixsl:if>
														</i>
														<i class="icon-star">
															<iaixsl:if test="@note &gt; 2.5"><iaixsl:attribute name="class"><![CDATA[icon-star active]]></iaixsl:attribute></iaixsl:if>
														</i>
														<i class="icon-star">
															<iaixsl:if test="@note &gt; 3.5"><iaixsl:attribute name="class"><![CDATA[icon-star active]]></iaixsl:attribute></iaixsl:if>
														</i>
														<i class="icon-star">
															<iaixsl:if test="@note &gt; 4.5"><iaixsl:attribute name="class"><![CDATA[icon-star active]]></iaixsl:attribute></iaixsl:if>
														</i>
													</span>
													<strong><iaixsl:value-of select="@note"/><![CDATA[/5]]></strong>
												</div>
											</div>
										</iaixsl:if>

										<div class="opinions_element_confirmed">
											<iaixsl:attribute name="class" ><![CDATA[opinions_element_confirmed --]]><iaixsl:value-of select="@confirmedByPurchase" /></iaixsl:attribute>
											<strong class="opinions_element_confirmed_text"><iaixsl:choose><iaixsl:when test="@confirmedByPurchase = 'true'"><iai:variable vid="Opinia potwierdzona zakupem"/></iaixsl:when><iaixsl:otherwise><iai:variable vid="Opinia niepotwierdzona zakupem"/></iaixsl:otherwise></iaixsl:choose></strong>
										</div>
									</div>
									<!-- OPINIE DESCRIPTION -->
									<div class="opinions_element_text">
										<iaixsl:value-of select="text" disable-output-escaping="yes"/>
									</div>
									<div class="opinions_element_opinion_bottom">
										<span class="opinion_date"><iaixsl:value-of select="@date"/></span>
										<!-- AUTOR OPINII -->
										<div class="opinion_author">
											<b class="opinions_element_author_title">

											</b>
											<span class="opinions_element_author_desc">
												<iaixsl:value-of select="@client"/>
											</span>
										</div>
										<div class="rate_opinion d-none">

											<span><iai:variable vid="Czy opinia była pomocna?"/></span>
											<a href="" class="opinion_rate_yes">
												<input name="opinionState" type="hidden">
													<iaixsl:attribute name="value"><![CDATA[positive]]></iaixsl:attribute>
												</input>
												<i class="icon-thumbs-up-empty"></i> <iai:variable vid="Tak"/> <span class="rate_count"><iaixsl:value-of select="@rate_yes"/></span>
											</a>
											<a href="" class="opinion_rate_no">
												<input name="opinionState" type="hidden">
													<iaixsl:attribute name="value"><![CDATA[negative]]></iaixsl:attribute>
												</input>
												<i class="icon-thumbs-down"></i> <iai:variable vid="Nie"/> <span class="rate_count"><iaixsl:value-of select="@rate_no"/></span>
											</a>
											<input name="opinionId" type="hidden">
												<iaixsl:attribute name="value"><iaixsl:value-of select="@opinionId"/></iaixsl:attribute>
											</input>
										</div>
									</div>
									<iaixsl:if test="response and response != ''">
										<div class="opinion_response">
											<div class="opinion_response_top">
												<b><iai:variable vid="Odpowiedź sklepu"/></b>
												<span class="opinion_date"><iaixsl:value-of select="response/@date"/></span>
											</div>
											<div class="response_text"><iaixsl:value-of select="response" disable-output-escaping="yes"/></div>
										</div>
									</iaixsl:if>
								</div>
							</div>
						</div>
					</iaixsl:for-each>
				</div>
				<div class="menu_messages_message d-none" id="no_opinions_of_type">
					<iai:variable vid="Brak opinii z taką liczbą gwiazdek"/>.
				</div>
				<!-- ZOBACZ WIĘCEJ -->
				<iaixsl:if test="$more_opinions and count(/shop/page/projector/comments/opinions/opinion) &gt; $count_opinions">
					<div class="opinions__more">
						<a href="#more_opinions" class="opinions__more_txt"><iaixsl:value-of select="$more_opinions"/></a>
					</div>
				</iaixsl:if>
			</div>
		</iaixsl:if>

		<!-- FORMULARZ DODAWANIA OPINII -->
		<iaixsl:if test="not(page/projector/comments/opinionClient/opinion/@stat = 'y')">
			<div class="opinions_add_form col-12">
				<iaixsl:if test="/shop/page/projector/comments/@all &gt; '0'">
					<iaixsl:attribute name="class"><![CDATA[opinions_add_form d-none]]></iaixsl:attribute>
				</iaixsl:if>

				<div class="big_label">
					<iaixsl:choose>
						<iaixsl:when test="(/shop/page/projector/comments/opinionClient/opinion/@stat = 'n')">
							<iai:variable vid="Zmień swoją opinię"/>
						</iaixsl:when>
						<iaixsl:otherwise>
							<iai:variable vid="Napisz swoją opinię"/>
						</iaixsl:otherwise>
					</iaixsl:choose>
				</div>
				<form class="row flex-column align-items-center shop_opinion_form" enctype="multipart/form-data" id="shop_opinion_form" action="/settings.php" method="post">
					<input type="hidden" name="product">
						<iaixsl:attribute name="value"><iaixsl:value-of select="page/projector/product/@id"/></iaixsl:attribute>
					</input>

					<!-- GWIAZDKI -->
					<div class="shop_opinions_notes col-12 col-sm-6">
						<div class="shop_opinions_name">
							<iai:variable vid="Twoja ocena"/>:
						</div>
						<div class="shop_opinions_note_items">
							<!-- OPINIE PROSTE CECH -->
							<div class="opinion_note">
								<iaixsl:variable name="starSelected">
									<iaixsl:choose>
										<iaixsl:when test="/shop/page/projector/comments/opinionClient/notes/note[@selected = 'true']/@value">
											<iaixsl:value-of select="/shop/page/projector/comments/opinionClient/notes/note[@selected = 'true']/@value"/>
										</iaixsl:when>
										<iaixsl:otherwise>
											<iaixsl:value-of select="count(/shop/page/projector/comments/opinionClient/notes/note)"/>
										</iaixsl:otherwise>
									</iaixsl:choose>
								</iaixsl:variable>
								<iaixsl:for-each select="/shop/page/projector/comments/opinionClient/notes/note">
									<a href="#" class="opinion_star">
										<iaixsl:choose>
											<iaixsl:when test="@value &gt; $starSelected">
												<iaixsl:attribute name="class"><![CDATA[opinion_star]]></iaixsl:attribute>
											</iaixsl:when>
											<iaixsl:otherwise>
												<iaixsl:attribute name="class"><![CDATA[opinion_star active]]></iaixsl:attribute>
											</iaixsl:otherwise>
										</iaixsl:choose>
										<iaixsl:attribute name="rel"><iaixsl:value-of select="@value"/></iaixsl:attribute>
										<iaixsl:attribute name="title">
											<iaixsl:value-of select="@value"/>/<iaixsl:value-of select="count(../note)"/>
										</iaixsl:attribute>
										<span>
											<i class="icon-star"> </i>
										</span>
									</a>
								</iaixsl:for-each>
								<strong>
									<iaixsl:value-of select="$starSelected"/>/<iaixsl:value-of select="count(/shop/page/projector/comments/opinionClient/notes/note)"/>
								</strong>
								<input type="hidden" name="note">
									<iaixsl:attribute name="value"><iaixsl:value-of select="@value"/></iaixsl:attribute>
									<iaixsl:choose>
										<iaixsl:when test="/shop/page/projector/comments/opinionClient/notes/note/@selected = 'true'">
											<iaixsl:attribute name="value"><iaixsl:value-of select="/shop/page/projector/comments/opinionClient/notes/note[@selected = 'true']/@value"/></iaixsl:attribute>
										</iaixsl:when>
										<iaixsl:otherwise>
											<iaixsl:attribute name="value"><iaixsl:value-of select="count(/shop/page/projector/comments/opinionClient/notes/note)"/></iaixsl:attribute>
										</iaixsl:otherwise>
									</iaixsl:choose>
								</input>
							</div>
						</div>
					</div>

					<!-- TREŚĆ OPINII -->
					<div class="form-group col-12 col-sm-7">
						<div class="has-feedback">
							<textarea id="addopp" class="form-control" name="opinion">
								<iaixsl:if test="/shop/page/projector/comments/opinionClient/opinion and not(/shop/page/projector/comments/opinionClient/opinion = '')">
									<iaixsl:attribute name="class"><![CDATA[form-control focused]]></iaixsl:attribute>
								</iaixsl:if>
								<iaixsl:value-of select="/shop/page/projector/comments/opinionClient/opinion"/>
							</textarea>
							<label for="opinion" class="control-label">
								<iai:variable vid="Treść twojej opinii"/>
							</label>
							<span class="form-control-feedback"/>

							<!-- Points -->
							<iaixsl:if test="/shop/page/projector/comments/opinionClient/opinion/@points">
								<strong class="opinions_points">
									<iaixsl:text><![CDATA[+ ]]></iaixsl:text>
									<iaixsl:choose>
										<iaixsl:when test="substring-after(/shop/page/projector/comments/opinionClient/opinion/@points, '.') = '00'">
											<iaixsl:value-of select="substring-before(/shop/page/projector/comments/opinionClient/opinion/@points, '.')"/>
										</iaixsl:when>
										<iaixsl:otherwise>
											<iaixsl:value-of select="/shop/page/projector/comments/opinionClient/opinion/@points"/>
										</iaixsl:otherwise>
									</iaixsl:choose>
									<iai:variable vid="pkt"/>.
								</strong>
							</iaixsl:if>
						</div>
					</div>

					<!-- ZDJĘCIE DO OPINII -->
					<iaixsl:if test="(page/projector/comments/opinionClient/image/@enabled='true')">
						<div class="opinion_add_photos col-12 col-sm-7">
							<div class="opinion_add_photos_wrapper d-flex align-items-center">
								<span class="opinion_add_photos_text">
									<i class="icon-file-image"></i>  <iai:variable vid="Dodaj własne zdjęcie produktu"/>:
								</span>
								<input class="opinion_add_photo" type="file" name="opinion_photo">
									<iaixsl:if test="/shop/form_data/upload_file/max_filesize/@bytes">
										<iaixsl:attribute name="data-max_filesize"><iaixsl:value-of select="/shop/form_data/upload_file/max_filesize/@bytes"/></iaixsl:attribute>
									</iaixsl:if>
								</input>

								<!-- Points -->
								<iaixsl:if test="/shop/page/projector/comments/opinionClient/image/@points">
									<strong class="opinions_points">
										<iaixsl:text><![CDATA[+ ]]></iaixsl:text>
										<iaixsl:choose>
											<iaixsl:when test="substring-after(/shop/page/projector/comments/opinionClient/image/@points, '.') = '00'">
												<iaixsl:value-of select="substring-before(/shop/page/projector/comments/opinionClient/image/@points, '.')"/>
											</iaixsl:when>
											<iaixsl:otherwise>
												<iaixsl:value-of select="/shop/page/projector/comments/opinionClient/image/@points"/>
											</iaixsl:otherwise>
										</iaixsl:choose>
										<iai:variable vid="pkt"/>.
									</strong>
								</iaixsl:if>
							</div>
							<iaixsl:if test="/shop/page/projector/comments/opinionClient/image/@points">
								<div class="opinions_points_picture">
									<iai:variable vid="Dodaj zrobione przez siebie zdjęcie tego produktu"/> <br/> <iai:variable vid="i zdobądź dodatkowe"/>
									<strong>
										<iaixsl:choose>
											<iaixsl:when test="substring-after(/shop/page/projector/comments/opinionClient/image/@points, '.') = '00'">
												<iaixsl:value-of select="substring-before(/shop/page/projector/comments/opinionClient/image/@points, '.')"/>
											</iaixsl:when>
											<iaixsl:otherwise>
												<iaixsl:value-of select="/shop/page/projector/comments/opinionClient/image/@points"/>
											</iaixsl:otherwise>
										</iaixsl:choose>
										<iai:variable vid="pkt"/>.
									</strong>
									<iai:variable vid="w naszym programie lojalnościowym"/>.
								</div>
							</iaixsl:if>
						</div>
					</iaixsl:if>

					<!-- OPINIE NIEZALOGOWANY -->
					<iaixsl:if test="/shop/page/projector/sender/@opinion_unregistered = 'true'">
						<div class="form-group col-12 col-sm-7">
							<div class="has-feedback has-required">
								<input id="addopinion_name" class="form-control" type="text" name="addopinion_name" value="">
									<iaixsl:attribute name="required"><![CDATA[required]]></iaixsl:attribute>
								</input>
								<label for="addopinion_name" class="control-label">
									<iai:variable vid="Twoje imię"/>
								</label>
								<span class="form-control-feedback"/>
							</div>
						</div>
						<div class="form-group col-12 col-sm-7">
							<div class="has-feedback has-required">
								<input id="addopinion_email" class="form-control" type="email" name="addopinion_email" value="">
									<iaixsl:attribute name="required"><![CDATA[required]]></iaixsl:attribute>
								</input>
								<label for="addopinion_email" class="control-label">
									<iai:variable vid="Twój email"/>
								</label>
								<span class="form-control-feedback"/>
							</div>
						</div>
					</iaixsl:if>
					<div class="shop_opinions_button col-12">
						<button type="submit" class="btn --solid --medium opinions-shop_opinions_button px-5">
							<iaixsl:choose>
								<iaixsl:when test="/shop/page/projector/comments/opinionClient/opinion and not(/shop/page/projector/comments/opinionClient/opinion = '')">
									<iaixsl:attribute name="title"><iai:variable vid="Zmień swoją opinię"/></iaixsl:attribute>
									<iaixsl:attribute name="data-button_edit"><![CDATA[true]]></iaixsl:attribute>
									<iai:variable vid="Zmień opinię"/>
								</iaixsl:when>
								<iaixsl:otherwise>
									<iaixsl:attribute name="title"><iai:variable vid="Dodaj opinię"/></iaixsl:attribute>
									<iai:variable vid="Wyślij opinię"/>
								</iaixsl:otherwise>
							</iaixsl:choose>
						</button>
					</div>
				</form>
			</div>
		</iaixsl:if>
	</section>
	<iaixsl:if test="/shop/page/projector/sender/@active='true'">
		<iaixsl:if test="/shop/page/projector/comments/opinions/opinion/response"/>
	</iaixsl:if>
<cdata-end/></iai:componentsdata></iai:component>