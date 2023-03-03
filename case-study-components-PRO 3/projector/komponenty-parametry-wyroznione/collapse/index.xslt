<?xml version="1.0" encoding="UTF-8"?><iai:component><iai:componentsdata><cdata-start/>
	<iaixsl:variable name="howManyTraits">5</iaixsl:variable>
	<iaixsl:variable name="collapseTraitID">60</iaixsl:variable>
	<iaixsl:variable name="collapseTraitIDHeadline">66</iaixsl:variable>
	
	
	<iaixsl:if test="/shop/page/projector/product/traits/trait[not(contains(@groupdescription, 'gs1:'))]">
		<section id="projector_producttraits" class="traits d-none mb-4 d-md-block">
			<div class="traits__wrapper">
				<iaixsl:for-each select="/shop/page/projector/product/traits/trait[not(contains(@groupdescription, 'gs1:'))]">
					<iaixsl:if test="not(@groupid = preceding-sibling::trait/@groupid) and not(@groupid = $collapseTraitID) and not(@groupid = $collapseTraitIDHeadline)">
						<div class="traits__item mb-2">
							<iaixsl:attribute name="data-hide"><iaixsl:choose><iaixsl:when test="position() &gt; $howManyTraits"><![CDATA[true]]></iaixsl:when><iaixsl:otherwise><![CDATA[false]]></iaixsl:otherwise></iaixsl:choose></iaixsl:attribute>
							<span class="traits__label mr-2"><iaixsl:value-of disable-output-escaping="yes" select="@groupdescription"/></span>
							<span class="traits__values d-inline-flex flex-wrap">
								<iaixsl:choose>
									<iaixsl:when test="@gfx">
										<a class="traits__value --gfx">
											<iaixsl:attribute name="href"><iaixsl:value-of select="@link"/></iaixsl:attribute>
											<img class="traits__gfx b-lazy" src="/gfx/pol/loader.gif?r=1652092768">
												<iaixsl:attribute name="data-src"><iaixsl:value-of select="@gfx"/></iaixsl:attribute>
												<iaixsl:attribute name="alt"><iaixsl:value-of select="@traitdescription"/></iaixsl:attribute>
											</img>
										</a>
									</iaixsl:when>
									<iaixsl:otherwise>
                    <a class="traits__value">
											<iaixsl:attribute name="href"><iaixsl:value-of select="@link"/></iaixsl:attribute>
											<iaixsl:value-of disable-output-escaping="yes" select="@traitdescription"/>
										</a>
									</iaixsl:otherwise>
								</iaixsl:choose>
								<iaixsl:if test="@groupid = following-sibling::trait/@groupid">
									<iaixsl:variable name="temporaryGroup"><iaixsl:value-of select="@groupid"/></iaixsl:variable>
									<iaixsl:for-each select="following-sibling::trait[(@groupid = $temporaryGroup)]">
										<iaixsl:choose>
											<iaixsl:when test="@gfx">
												<a class="traits__value --gfx">
													<iaixsl:attribute name="href"><iaixsl:value-of select="@link"/></iaixsl:attribute>
													<img class="traits__gfx b-lazy" src="/gfx/pol/loader.gif?r=1652092768">
														<iaixsl:attribute name="data-src"><iaixsl:value-of select="@gfx"/></iaixsl:attribute>
														<iaixsl:attribute name="alt"><iaixsl:value-of select="@traitdescription"/></iaixsl:attribute>
													</img>
												</a>
											</iaixsl:when>
											<iaixsl:otherwise>
                        <a class="traits__value">
                            <iaixsl:attribute name="href"><iaixsl:value-of select="@link"/></iaixsl:attribute>
                            <iaixsl:value-of disable-output-escaping="yes" select="@traitdescription"/>
                        </a>
											</iaixsl:otherwise>
										</iaixsl:choose>
									</iaixsl:for-each>
								</iaixsl:if>
							</span>
						</div>
					</iaixsl:if>
				</iaixsl:for-each>
			</div>
			<iaixsl:if test="count(/shop/page/projector/product/traits/trait[not(contains(@groupdescription, 'gs1:')) and not(@groupid = preceding-sibling::trait/@groupid)]) &gt; $howManyTraits">
				<a href="#showAllTraits" class="traits__all"><iai:variable vid="Pokaż wszystkie"/></a>
			</iaixsl:if>
		</section>

    <iaixsl:if test="/shop/page/projector/product/traits/trait[contains(@groupid, $collapseTraitID)]">
        <section id="projector_collapse" class="projector_collapse --collapse-wrapper --skeleton">
            <span class="projector_collapse__headline">
                <span class="headline_name"><iaixsl:value-of disable-output-escaping="yes" select="/shop/page/projector/product/traits/trait[@groupid = $collapseTraitID]/@groupdescription"/></span>
                <iaixsl:if test="/shop/page/projector/product/traits/trait[contains(@groupid, $collapseTraitIDHeadline)]">
                    <span class="headline_after"><iaixsl:value-of disable-output-escaping="yes" select="/shop/page/projector/product/traits/trait[@groupid = $collapseTraitIDHeadline]/@traitlongdescription"/></span>
                </iaixsl:if>
            </span>
            <iaixsl:for-each select="/shop/page/projector/product/traits/trait">
                <iaixsl:if test="@groupid = $collapseTraitID">
                    <div class="collapse__wrapper --item">
                        <a href="#" class="collapse__headline --link">
                            <iaixsl:value-of disable-output-escaping="yes" select="@traitdescription"/>
                        </a>
                        <iaixsl:if test="description">
                            <div class="collapse__description --list">
                                <iaixsl:value-of disable-output-escaping="yes" select="description"/>
                            </div>
                        </iaixsl:if>
                    </div>
                </iaixsl:if>
            </iaixsl:for-each>
        </section>
    </iaixsl:if>
	</iaixsl:if>
<cdata-end/></iai:componentsdata></iai:component>