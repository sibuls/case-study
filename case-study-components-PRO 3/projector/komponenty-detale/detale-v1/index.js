app_shop.run(function projectorFormAppShop() {
    app_shop.fn.projectorForm = new ProjectorForm();
    app_shop.fn.projectorForm.init();
  }, 'all', '#projector_form', true);
  
  // Wywołanie expressCheckoutApi.initCheckout po kliknięciu przycisku płatności, przekazanie danych formularza
  app_shop.fn.getExpressCheckoutData = async (e) => {
    if (typeof expressCheckoutApi !== 'undefined' && typeof expressCheckoutApi.initCheckout === 'function') {
      const serializeForm = new URLSearchParams(new FormData(document.getElementById('projector_form')));
      const currentElement = (e.target) ? e.target : e;
      const currentId = currentElement.closest('.projector_oneclick__item').getAttribute('data-id');
      await expressCheckoutApi.initCheckout(currentId, serializeForm);
    }
  };
  
  // Sprawdzenie, czy są wybrane rozmiary/warianty
  app_shop.fn.checkProjectorData = (withoutAlert) => {
    if (!app_shop.fn.projectorForm.sizeSelected()) {
      if (!withoutAlert) app_shop.fn.projectorForm.alertProjector();
      return false;
    }
    if (!app_shop.fn.bundleVersionSelected(withoutAlert)) { return false; }
    if (!app_shop.fn.bundleSizeSelected(withoutAlert)) { return false; }
    const moreElement = document.querySelector('.projector_buy__more');
    if (moreElement) moreElement.classList.add('--active');
    const numberElements = document.querySelectorAll('.projector_buy__number, .projector_buy__number .f-dropdown-toggle');
    numberElements.forEach((el) => {
      el.classList.remove('--disabled');
    });
    const productNameElement = document.querySelector('h1.product_name__name');
    const oneClickWrapperElement = document.querySelector('.projector_oneclick');
    const oneClickItems = document.querySelectorAll('.projector_oneclick__item');
    oneClickItems.forEach((el) => {
      if (productNameElement && productNameElement.textContent.length === 0) {
        el.classList.remove('--checked');
        if (oneClickWrapperElement) oneClickWrapperElement.setAttribute('data-hide', true);
      } else {
        el.classList.add('--checked');
      }
    });
    return true;
  };
  
  // Odpalenie sprawdzania, czy są wybrane rozmiary/warianty po kliknięciu w płatność
  const expressCheckoutApiClickEvent = (e) => {
    const currentItem = e.target.closest('.projector_oneclick__item');
    if (currentItem.classList.contains('--loading')) return false;
    if (!app_shop.fn.checkProjectorData()) return false;
    return true;
  };
  
  app_shop.run(function expressCheckoutApiAppShop() {
    const oneClickItems = document.querySelectorAll('.projector_oneclick__item');
    oneClickItems.forEach((el) => {
      // Werwyfikacja wybranych rozmiarów / wariantów
      el.addEventListener('click', expressCheckoutApiClickEvent);
  
      // Wyrenderowanie przycisku płatności
      if (typeof expressCheckoutApi !== 'undefined' && typeof expressCheckoutApi.renderButton === 'function') {
        const currentId = el.getAttribute('data-id');
        expressCheckoutApi.renderButton(currentId, el);
      }
    });
  }, 'all', '.projector_oneclick__item', true);
  
  app_shop.run(function projectorFormAppShopOnce() {
    // FIX dla przycisku wstecz po zmianie wariantu
    app_shop.vars.curr_url_projector = location.pathname;
    $(window).on('popstate', function popstateFunction() {
      if (app_shop.vars.curr_url_projector !== location.pathname) {
        window.location.href = window.location.href;
      }
    });
  }, 'all', '#projector_form');
  
  const projectorFormatPrice = (obj) => format_price(obj.price, {
    mask: app_shop.vars.currency_format,
    currency: obj.currency,
    currency_space: app_shop.vars.currency_space,
    currency_before_price: app_shop.vars.currency_before_value
  });
  
  app_shop.fn.updateYouSave = () => {
    // Promocja ograniczona - aktualizacja %
    if (($('#projector_form[data-collection]').length && $('#projector_form[data-collection] .projector_bundle__checkbox:checked').length === 1)) {
      $('#projector_price_yousave').hide();
    } else if (projectorObj.currentSizeObj.phone_price != 'true' && (typeof yousaveTmp !== 'undefined' && !isNaN(yousaveTmp))) {
      $('#projector_price_yousave').show().html(`<span class="projector_prices__percent_value">-${(+yousave_percentTmp < 1) ? yousave_percentTmp : yousave_percentTmp.split('.')[0]}%</span>`);
      $('#projector_price_maxprice_wrapper').show();
    } else {
      $('#projector_price_yousave').hide();
    }
  };
  
  function projectorEndStartCallback() {
    app_shop.fn.updateYouSave();
  
    // Aktualizacja rabatu ilościowego
    const {price} = projectorObj.currentSizeObj;
    if (typeof price !== 'undefined' && $('#projector_rebateNumber').length && typeof price.rebateNumber !== 'undefined') {
      $('#projector_form .projector_multipack').addClass('--active').removeClass('--hide');
      const {rebateNumber} = price;
      const rebateThreshold = (projectorObj.rebateThreshold) ? parseFloat(projectorObj.rebateThreshold, 10) : false;
      if ($('.projector_multipack__item').length > 1) {
        $('.projector_multipack__item').each(function(index) {
          $(this).find('.projector_multipack__price').text((app_shop.vars.priceType === 'net') ? rebateNumber.items[index].price_net_formatted : rebateNumber.items[index].price_formatted);
          if (rebateThreshold && rebateThreshold === parseFloat($(this).data('value'), 10)) {
            $(this).find('input').prop('checked', true);
          } else {
            $(this).find('input').prop('checked', false);
          }
        });
      } else {
        $('.projector_multipack__price').text((app_shop.vars.priceType === 'net') ? rebateNumber.nextprice_net_formatted : rebateNumber.nextprice_formatted);
        if (rebateThreshold && rebateThreshold === parseFloat($('.projector_multipack__item').data('value'), 10)) {
          $('.projector_multipack__item input').prop('checked', true);
        } else {
          $('.projector_multipack__item input').prop('checked', false);
        }
      }
    } else if ($('#projector_rebateNumber').length) {
      $('#projector_form .projector_multipack').addClass('--hide');
    }
  
    // Aktualizacja danych ExpressCheckout
    if (typeof expressCheckoutApi !== 'undefined' && typeof expressCheckoutApi.refreshInitData === 'function') {
      expressCheckoutApi.refreshInitData();
    }
    app_shop.fn.checkProjectorData(true);
  
    // Subskrypcja
    const { amount } = projectorObj.currentSizeObj;
    if (typeof amount !== 'undefined' && +amount > 0) {
      const numberInput = document.getElementById('projector_number');
      const minimumQuantity = numberInput.getAttribute('data-minimum-quantity-subscription') || numberInput.getAttribute('data-minimum-quantity')
      || numberInput.getAttribute('data-sellby');
      const projectorElement = document.getElementById('projector_form');
      if (+minimumQuantity > +amount) {
        projectorElement.classList.add('disable');
      }
    }
  }
  
  function projectorEndInitFunctionCallback() {
  }
  
  app_shop.run(function SmileMore() {
    $('.projector_smile__link, .smile_basket__link').on('click', function SmileMoreClick(e) {
      e.stopPropagation();
      Modal({
        element: $('.smile_info'),
        classList: '--smile',
      });
      return false;
    });
  }, 'all', '.smile_info', true);
  
  app_shop.run(function ProductStocksAppShop() {
    app_shop.fn.productStocks = new ProductStocks({
      stockLinkSelector: '.projector_stocks__info.--link',
    });
    app_shop.fn.productStocks.init();
  }, 'all', '.projector_stocks__info.--link', true);
  
  app_shop.run(function PayPoMore() {
    $('.projector_paypo__link, .paypo_basket__link').on('click', function PayPoMoreClick(e) {
      e.stopPropagation();
      Modal({
        element: $('.paypo_info'),
        classList: '--paypo',
      });
      return false;
    });
  }, 'all', '.paypo_info', true);
  
  app_shop.run(function calculateInstalmentsAppShop() {
    $('.projector_instalments__link').on('click', function calculateInstalmentsClick() {
      $('.projector_instalments').toggleClass('--active');
      app_shop.vars.bLazy.revalidate();
      return false;
    });
  }, 'all', '.projector_instalments__link', true);
  
  app_shop.run(function addToShoppingListProjector() {
    $('.projector_buy__shopping_list, .projector_tell_availability__shopping_list').on('click', function addToShoppingListProjector(e) {
      if (!app_shop.fn.projectorForm.sizeSelected()) { app_shop.fn.projectorForm.alertProjector(); return false; }
      if (typeof app_shop.fn.bundleSizeSelected === 'function' && !app_shop.fn.bundleSizeSelected()) { return false; }
      app_shop.fn.shoppingList.addProductToList([[document.getElementById('projector_product_hidden').value, document.getElementById('projector_size_hidden').value]]);
      return false;
    });
  }, 'all', '.projector_buy__shopping_list', true);
  var projectorv3_disable_ajax = "1";
  
  projectorObj = new projectorClass();
  
  projectorObj.txt['additional_texts'] = ""
  projectorObj.txt['za'] = " " + <iai:variable vid="za"/> + " "
  projectorObj.txt['taniej'] = "% ("
  projectorObj.txt['oszczedzasz'] = "(" + <iai:variable vid="Zniżka"/> + " "
  projectorObj.txt['wzestawie'] = "), " + <iai:variable vid="kupując w zestawie"/> + ". "
  projectorObj.txt['niedostepny'] = <iai:variable vid="Produkt niedostępny"/>
  projectorObj.txt['tylkotel'] = <iai:variable vid="Cena na telefon. Skontaktuj się ze sprzedawcą"/> + "."
  projectorObj.txt['tylko_punkty'] = <iai:variable vid="Produkt dostępny tylko w programie lojalnościowym"/> + "."
  projectorObj.txt['za_malo_punktow'] = <iai:variable vid="Nie masz wystarczającej ilości punktów"/>
  projectorObj.txt['gratis'] = <iai:variable vid="Wysyłka gratis!"/>
  projectorObj.txt['niemastanu'] = <iai:variable vid="Produkt niedostępny"/>
  projectorObj.txt['status_24'] = <iai:variable vid="24 godz"/> + "."
  projectorObj.txt['status_48'] = <iai:variable vid="48 godz"/> + "."
  projectorObj.txt['status_natychmiast'] = <iai:variable vid="Natychmiast"/>
  projectorObj.txt['day'] = " " + <iai:variable vid="dzień"/> + " "
  projectorObj.txt['days'] = " " + <iai:variable vid="dni"/> + "  "
  projectorObj.txt['hour'] = " " + <iai:variable vid="godz"/> + "."
  projectorObj.txt['hours'] = " " + <iai:variable vid="godz"/> + ". "
  projectorObj.txt['min'] = " min "
  projectorObj.txt['mins'] = " min. "
  projectorObj.txt['proc'] = "%"
  projectorObj.txt['wybrany_rozmiar'] = <iai:variable vid="Rozmiar"/> + ":"
  projectorObj.txt['wysylka'] = <iai:variable vid="Wysyłka"/> + " "
  projectorObj.txt['wysylka_za'] = <iai:variable vid="Wysyłka w ciągu"/> + " "
  projectorObj.txt['shipmentIn'] = <iai:variable vid="Wysyłka za"/> + " "
  projectorObj.txt['tomorrow'] = " " + <iai:variable vid="jutro"/>
  projectorObj.txt['dostepny'] = ""
  projectorObj.txt['dostepny_za'] = " " + <iai:variable vid="za"/> + " "
  projectorObj.txt['pkt'] = " " + <iai:variable vid="pkt"/> + "."
  projectorObj.txt['status_amount_full'] = <iai:variable vid="większa ilość"/>
  projectorObj.txt['status_amount_null'] = <iai:variable vid="brak w magazynie"/>
  projectorObj.txt['forpointsonly'] = <iai:variable vid="Produkt możesz kupić za punkty"/> + "."
  projectorObj.txt['disable_desc'] = <iai:variable vid="Skontaktuj się z nami"/> + "."
  projectorObj.txt['choiceSize'] = <iai:variable vid="Wybierz rozmiar"/>
  projectorObj.txt['maksymalnie'] = <iai:variable vid="Maksymalnie możesz dodać"/>
  projectorObj.txt['minimalnie'] = <iai:variable vid="Minimalnie musisz zamówić"/> + " "
  projectorObj.txt['brak_magazyn'] = <iai:variable vid="Brak na magazynie"/>
  projectorObj.txt['koszt_od'] = <iai:variable vid="Koszt od"/> + " "
  projectorObj.txt['wysylka_total_begin'] = "<br/>(" + <iai:variable vid="z tow. z koszyka"/> + " "
  projectorObj.txt['wysylka_total_end'] = ")"
  projectorObj.txt['nawias_end_collection'] = "% " + <iai:variable vid="kupując w kolekcji"/> + ")"
  projectorObj.txt['nawias_end_bundle'] = "% " + <iai:variable vid="kupując w zestawie"/> + ")"
  projectorObj.txt['nawias_end'] = "%)"
  projectorObj.txt['gratis_produkt'] = <iai:variable vid="Gratis!"/>
  projectorObj.txt['virtual_inbasket'] = <iai:variable vid="Produkt znajduje się już w koszyku"/>
  projectorObj.txt['infinity'] = ""
  projectorObj.txt['ilosc_mm'] = "" + <iai:variable vid="Aktualnie w naszym magazynie mamy"/> + " <b>" + "%" + <iai:variable vid="d"/> + "</b>."
  projectorObj.txt['ilosc_mo'] = "" + <iai:variable vid="Kolejne"/> + " <b>" + "%" + <iai:variable vid="d"/> + "</b> " + <iai:variable vid="możemy sprowadzić na zamówienie"/> + "."
  projectorObj.txt['ilosc_mo_inf'] = <iai:variable vid="Dowolną ilość możemy sprawadzić na zamówienie"/> + "."
  projectorObj.txt['size_select_functionality'] = "0"
  projectorObj.txt['sizes_projector_functionality'] = "1"
  projectorObj.txt['size_select_label'] = <iai:variable vid="Rozmiar"/> + ":"
  projectorObj.txt['size_select_tell_availability'] = <iai:variable vid="Powiadom o dostępności"/>
  projectorObj.txt['size_select_last_unit'] = <iai:variable vid="Ostatnia sztuka!"/>
  projectorObj.txt['size_select_few_last_units'] = <iai:variable vid="Ostatnie sztuki!"/>
  projectorObj.txt['order_by'] = <iai:variable vid="Zamów do"/> + " "
  projectorObj.txt['it_will_ship_today'] = " " + <iai:variable vid="to wyślemy dzisiaj"/>
  
  var Projector_txt_maksymalnie = <iai:variable vid="Maksymalnie możesz zamówić"/> + ": "
  var Projector_txt_minimalnie = projectorObj.txt['minimalnie'];
  var Projector_txt_brak_magazyn = <iai:variable vid="Brak na magazynie"/>
  var Projector_txt_produkt_niedostepny = <iai:variable vid="Produkt niedostępny"/>
  var Projector_txt_podajilosc = <iai:variable vid="Podaj ilość dla wybranego rozmiaru"/>
  var Projector_txt_zalogujsie = <iai:variable vid="Zaloguj się"/>
  var Projector_txt_closedialog = ""
  var txt_raty_button1 = <iai:variable vid="Oblicz raty wybranego produktu"/>
  var txt_raty_button2 = <iai:variable vid="Oblicz raty wraz z kwotą z koszyka"/> + " "
  var txt_62619_cms_table = <iai:variable vid="Tabela rozmiarów"/>
  var txt_toltip_1 = <iai:variable vid="Cena najtańszej z dostępnych form wysyłki z uwzględnieniem twojego koszyka. Pełną listę cen i kurierów otrzymasz podczas składania zamówienia"/> + "."
  var txt_toltip_2 = <iai:variable vid="Program lojalnościowy dostępny jest tylko dla zalogowanych klientów"/> + "."
  var txt_toltip_2a = <iai:variable vid="Możesz zamienić zgromadzone punkty lojalnościowe na ten produkt. Obecnie masz [xxx] punktów"/> + "."
  var txt_toltip_3 = <iai:variable vid="Po opłaceniu zamówienia przyznamy ci taką ilość punktów lojalnościowych. Żeby zbierać punkty musisz być zarejestrowanym klientem"/> + "."
  var txt_toltip_3a = <iai:variable vid="Po opłaceniu zamówienia przyznamy ci taką ilość punktów lojalnościowych"/> + "."
  var txt_toltip_4 = ""
  var prepaid = <iai:variable vid="Płatność przed wysyłką"/>
  var dvp = <iai:variable vid="Płatność przy odbiorze"/>
  var day_txt = " " + <iai:variable vid="dzień"/> + " "
  var days_txt = " " + <iai:variable vid="dni"/> + " "
  var hour_txt = " " + <iai:variable vid="godz"/> + ". "
  var hours_txt = " " + <iai:variable vid="godz"/> + ". "
  var min_txt = " min."
  var txt_24h = <iai:variable vid="24h"/>
  var txt_do_24h = <iai:variable vid="do 24h"/>
  var delivery_txt = <iai:variable vid="Sam transport zajmie"/> + " "
  var delivery_txt2 = <iai:variable vid="Przygotowanie do odbioru osobistego zajmie"/> + " "
  var delivery_txt3 = <iai:variable vid="Forma dostawy dostępna od"/> + " "
  var gratis_txt = <iai:variable vid="Gratis!"/>
  app_shop.txt.txt_74629_1 = <iai:variable vid="Do końca promocji"/> + ": "
  app_shop.txt.txt_74629_2 = <iai:variable vid="Wybierz inną opcję"/> + "."
  app_shop.txt.txt_74629_3 = <iai:variable vid="dni"/>
  app_shop.txt.txt_74629_4 = <iai:variable vid="godzin"/> + " "
  app_shop.txt.txt_74629_5 = <iai:variable vid="minut"/> + " "
  app_shop.txt.txt_74629_6 = <iai:variable vid="sekund"/> + " "
  app_shop.txt.txt_74629_7 = <iai:variable vid="Przepraszamy, ale nie zdefiniowaliśmy standardowego kosztu dostawy, zostanie on ustalony indywidualnie przez naszą obsługę po przyjęciu zamówienia"/> + "."
  var txt_shipping_8 = " " + <iai:variable vid="dzisiaj"/>
  var txt_shipping_9 = " " + <iai:variable vid="w poniedziałek"/> + " "
  var txt_shipping_10 = " " + <iai:variable vid="we wtorek"/> + " "
  var txt_shipping_11 = " " + <iai:variable vid="w środę"/> + " "
  var txt_shipping_12 = " " + <iai:variable vid="w czwartek"/> + " "
  var txt_shipping_13 = " " + <iai:variable vid="w piątek"/> + " "
  var txt_shipping_14 = " " + <iai:variable vid="w sobotę"/> + " "
  var txt_shipping_15 = " " + <iai:variable vid="w niedzielę"/> + " "
  var txt_shipping_16 = <iai:variable vid="jutro!"/>
  app_shop.txt.txt_74629_8 = <iai:variable vid="Proszę wybrać rozmiar"/>
  projectorObj.options['friendly_shipping_format'] = [txt_shipping_8, txt_shipping_9, txt_shipping_10, txt_shipping_11, txt_shipping_12, txt_shipping_13, txt_shipping_14, txt_shipping_15];
  
  app_shop.txt.txt_74629_9 = <iai:variable vid="Twój produkt jest gotowy do wysyłki"/>;
  app_shop.txt.txt_74629_10 = <iai:variable vid="Twój produkt jest już spakowany i gotowy do odebrania przez kuriera"/>;
  app_shop.txt.txt_74629_11 = <iai:variable vid="Czas przygotowania produktu do wysyłki"/>;
  app_shop.txt.txt_74629_11a = <iai:variable vid="Gotowy do wysyłki"/>;
  app_shop.txt.txt_74629_11b = <iai:variable vid="Produkt jest spakowany i możliwy do odebrania przez kuriera"/>;
  app_shop.txt.txt_74629_12 = <iai:variable vid="Jest to czas, w którym produkt jest pakowany i przygotowywany do odebrania przez kuriera"/>;
  app_shop.txt.txt_74629_13 = "";
  app_shop.txt.txt_74629_14 = <iai:variable vid="Przygotowanie do odbioru osobistego zajmie do 24h"/>;
  app_shop.txt.txt_74629_15 = <iai:variable vid="Przygotowanie do odbioru osobistego zajmie 24h"/>;
  app_shop.txt.txt_74629_16 = <iai:variable vid="Przygotowanie do odbioru osobistego zajmie"/> + " ";
  app_shop.txt.txt_74629_17 = <iai:variable vid="Przesyłka będzie u Ciebie dzisiaj!"/> + " ";
  app_shop.txt.txt_74629_18 = <iai:variable vid="Przesyłka będzie u Ciebie jutro!"/>;
  app_shop.txt.txt_74629_19 = <iai:variable vid="Przesyłka będzie u Ciebie za"/> + " ";
  app_shop.txt.txt_74629_16467 = <iai:variable vid="Zamknij okno"/>;
  app_shop.txt.txt_74629_conflict = <iai:variable vid="Wybór tej pozycji spowoduje konieczność dostosowania innych opcji"/> + ". ";
  app_shop.txt.txt_sold_out = <iai:variable vid="wyprzedane"/>;
  
  
  var txt_62619_nieprawidlowy_email = <iai:variable vid="Niepoprawny adres email"/> + "."
  var txt_62619_przekroczono_liczbe = <iai:variable vid="Przekroczono liczbę dodanych powiadomień w ciągu dnia"/> + "."
  var txt_62619_podczas_dodawania = <iai:variable vid="Podczas dodawania produktu wystąpił błąd. Sprawdź poprawność wprowadzonych danych"/>
  var txt_62619_produkt_dodany = <iai:variable vid="Produkt został poprawnie dodany do powiadomień"/> + "."
  var txt_62619_blad_pobrania = <iai:variable vid="Wystąpił problem z połączeniem. Wykonaj czynność ponownie"/> + "."
  var txt_62619_bledny_email = <iai:variable vid="Błędnie wpisany e-mail. Wpisz pełny adres e-mail, np. jan@kowalski.com"/> + " "
  var txt_62619_wpisz_telefon = <iai:variable vid="Wpisz swój telefon"/> + ". "
  var fashionGallery_new = "";
  app_shop.txt.daysOfWeek = [
    <iai:variable vid="Dzisiaj"/>,
    <iai:variable vid="Poniedziałek"/>,
    <iai:variable vid="Wtorek"/>,
    <iai:variable vid="Środa"/>,
    <iai:variable vid="Czwartek"/>,
    <iai:variable vid="Piątek"/>,
    <iai:variable vid="Sobota"/>,
    <iai:variable vid="Niedziela"/>,
  ];
  app_shop.txt.shippingInfoVat = "* " + <iai:variable vid="Cena brutto (z VAT)"/>;
  app_shop.txt.shippingInfoPrepaid = <iai:variable vid="Płatność przed wysyłką"/>;
  app_shop.txt.shippingInfoDvp = <iai:variable vid="Płatność przy odbiorze"/>;
  app_shop.txt.shippingInfoHeaderName = <iai:variable vid="Forma dostawy"/>;
  app_shop.txt.shippingInfoHeaderDelivery = <iai:variable vid="Przewidywana dostawa"/>;
  app_shop.txt.shippingInfoHeaderCost = <iai:variable vid="Cena"/> + " *";
  
  // Countdown timer
  function CountdownTimer(elm, tl) {
    this.initialize.apply(this, arguments);
  }
  
  CountdownTimer.prototype = {
    initialize: function (elm, tl) {
      this.elem = elm;
      this.tl = tl;
      this.tid = '';
    },
    newData: function (tl) {
      this.tl = tl;
    },
    countDown: function () {
      var timer = '';
      var today = new Date();
      var day = Math.floor((this.tl - today) / (24 * 60 * 60 * 1000));
      var hour = Math.floor(((this.tl - today) % (24 * 60 * 60 * 1000)) / (60 * 60 * 1000));
      var min = Math.floor(((this.tl - today) % (24 * 60 * 60 * 1000)) / (60 * 1000)) % 60;
      var sec = Math.floor(((this.tl - today) % (24 * 60 * 60 * 1000)) / 1000) % 60 % 60;
  
      var me = this;
      if ((this.tl - today) > 0) {
        timer += '<label class="projector_label">' + app_shop.txt.txt_74629_1 + '</label><div>';
        if (this.addZero(day) > 0)
        timer += '<span class="number-wrapper"><div class="line"></div><div class="caption">' + app_shop.txt.txt_74629_3 + '</div><span class="number day">' + this.addZero(day) + '</span></span>';
        timer += '<span class="number-wrapper"><div class="line"></div><div class="caption">' + app_shop.txt.txt_74629_4 + '</div><span class="number hour">' + this.addZero(hour) + '</span></span>';
        timer += '<span class="number-wrapper"><div class="line"></div><div class="caption">' + app_shop.txt.txt_74629_5 + '</div><span class="number min">' + this.addZero(min) + '</span></span><span class="number-wrapper"><div class="line"></div><div class="caption">' + app_shop.txt.txt_74629_6 + '</div><span class="number sec">' + this.addZero(sec) + '</span></span></div>';
        this.elem.html(timer);
        this.tid = setTimeout(function () { me.countDown(); }, 1000);
      } else {
        clearTimeout(this.tid);
        this.elem.remove();
        return;
      }
    }, addZero: function (num) { return (num.toString().length === 1) ? (`0${num}`).slice(-2) : num; }
  }
  
  /**
   * Przygotowanie parametrów wejściowych dla bramki shipping na karcie produktu
   * @returns {string} - ShippingInput dla bramki shipping GraphQL
  */
  app_shop.graphql.projectorShippingInput = () => {
    const isBundle = document.querySelector('#projector_form[data-type="product_bundle"]');
    let bundleParts = '';
    // Dane dla zestawów, kolekcji
    if (isBundle) {
      const isCollection = document.querySelector('#projector_form[data-collection]');
      const currentBundleItems = (isCollection) ? document.querySelectorAll('.projector_bundle__checkbox:checked') : document.querySelectorAll('.projector_bundle__item');
      bundleParts = `bundleParts: [${[...currentBundleItems].map((el) => `{
        id: ${el.closest('.projector_bundle__item').querySelector('.projector_bundle__product_id').value}
        size: "${(el.closest('.projector_bundle__item').querySelector('.projector_bundle__product_size')) ? el.closest('.projector_bundle__item').querySelector('.projector_bundle__product_size').value : el.closest('.projector_bundle__item').querySelector('.projector_bundle__size-select').value}"
      }`).join('')}]`;
    }
  
    return `ShippingInput: {
      mode: product
      products: [{
        id: ${document.getElementById('projector_product_hidden').value}
        size: "${(document.getElementById('projector_size_hidden').value === 'onesize') ? 'uniw' : document.getElementById('projector_size_hidden').value}"
        quantity: ${(document.getElementById('projector_number')) ? document.getElementById('projector_number').value : product_data.unit_sellby}
        ${bundleParts}
      }]
    }`;
  };
  
  /**
   * Pobranie danych o czasie potrzebnym na przygotowanie zamówienia do wysyłki z bramki shipping
   * @param {string} shippingInput - parametry wejściowe - na karcie można skorzystać z app_shop.graphql.projectorShippingInput()
   * @returns {object} - odpowiedź z bramki
  */
  app_shop.graphql.getShippingTime = async (shippingInput) => {
    const shippingTimeQuery = JSON.stringify({
      query: `query {
        shipping(${shippingInput}) {
          shippingTime {
            shippingTime {
              time {
                days
                hours
                minutes
              }
              weekDay
              weekAmount
              today
            }
            time
            unknownTime
            todayShipmentDeadline
          }
        }
      }`,
    });
  
    try {
      const response = await fetch(app_shop.urls.graphql, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Accept: 'application/json',
        },
        body: shippingTimeQuery,
      });
      const dataJson = await response.json();
      return dataJson;
    } catch (error) {
      console.error('AJAX fetchDataShippingTime() Error:', error);
      return false;
    }
  };
  
  /**
   * Pobranie danych o dostępnych kurierach z bramki shipping
   * @param {string} shippingInput - parametry wejściowe - na karcie można skorzystać z app_shop.graphql.projectorShippingInput()
   * @returns {object} - odpowiedź z bramki
  */
  app_shop.graphql.getCouriersForModal = async (shippingInput) => {
    const shippingQuery = JSON.stringify({
      query: `query {
        shipping(${shippingInput}) {
          shipping {
            courier {
              icon
              name
            }
            prepaid
            cost {
              value
              formatted
            }
            deliveryTime {
              time {
                days
                hours
                minutes
              }
              weekDay
              weekAmount
              today
            }
          }
        }
      }`,
    });
  
    try {
      const response = await fetch(app_shop.urls.graphql, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Accept: 'application/json',
        },
        body: shippingQuery,
      });
      const dataJson = await response.json();
      return dataJson;
    } catch (error) {
      console.error('GraphQL fetchDataShipping() Error:', error);
      return false;
    }
  };
  
  /**
   * Modal z dostępnym kurierami
   * @param {object} params - obiekt z wszystkimi opcjami, callback'ami
   * @param {function} getCouriersFunction - funkcja pobierająca dane z bramki shipping
   * @param {function} productParamsFunction - funkcja, która zwróci parametry wejściowe dla bramki shipping
   * @param {function} afterShowModal - funkcja, która odpali się po pojawieniu się modalu
   * @param {function} onlyHtml - funkcja, która odpali się zamiast modalu
  */
  ShippingInfo = function shippingInfoFunction(params) {
    const that = this;
    this.params = params || {};
    this.couriersDataBuffer = [];
  
    /**
     * Obliczanie daty, która będzie za x dni, x godzin, x minut
     * @param {object} time - obiekt z parametrami wejściowymi
     * @param {integer} days - ilość dni
     * @param {integer} hours - ilość godzin
     * @param {integer} minutes - ilość minut
     * @returns {string} - data w formacie Dzień.Miesiąc np. 13.10
     */
    this.calculateDate = (time) => {
      const {
        days,
        hours,
        minutes,
      } = time;
      const nowDate = new Date();
      if (typeof days !== 'undefined') nowDate.setDate(nowDate.getDate() + parseInt(days, 10));
      if (typeof hours !== 'undefined') nowDate.setHours(nowDate.getHours() + parseInt(hours, 10));
      if (typeof minutes !== 'undefined') nowDate.setMinutes(nowDate.getMinutes() + parseInt(minutes, 10));
      return nowDate.toJSON().slice(0, 10).split('-').reverse().slice(0, -1).join('.');
    };
  
    /**
     * Przygotowanie HTML'a dla pojedynczego kuriera
     * @param {object} courierData - dane kuriera
     * @returns {node} - przygotowany element HTML
     */
    this.getCourierHtml = (courierData) => {
      const courierElement = document.createElement('div');
      courierElement.classList.add('shipping_info__courier');
      const iconLink = courierData.courier.icon;
      const courierName = courierData.courier.name;
      const deliveryDayName = (courierData.deliveryTime.today) ? app_shop.txt.daysOfWeek[0] : app_shop.txt.daysOfWeek[courierData.deliveryTime.weekDay];
      const deliveryDate = (courierData.deliveryTime.weekAmount > 0) ? `\u00A0(${that.calculateDate({
        days: courierData.deliveryTime.time.days,
        hours: courierData.deliveryTime.time.hours,
        minutes: courierData.deliveryTime.time.minutes,
      })})` : '';
      const cost = (courierData.cost.value > 0) ? courierData.cost.formatted : gratis_txt;
      courierElement.innerHTML = `<span class="shipping_info__item --icon"><img src="${iconLink}" alt="${courierName}"/></span>
      <span class="shipping_info__item --name">${courierName}</span>
      <span class="shipping_info__item --delivery">${deliveryDayName}${deliveryDate}</span>
      <strong class="shipping_info__item --cost">${cost}</strong>`;
      return courierElement;
    };
  
    /* Stworzenie modalu z informacjami o dostępnych kurierach */
    this.create = async () => {
      // Skrót z parametrów wejściowych bramki shipping
      const productParamsMD5 = md5(this.productParamsFunction());
      // Sprawdzenie, czy dane były już pobrane
      const bufferFiltered = this.couriersDataBuffer.filter((el) => el.key === productParamsMD5);
      let dataJson = {};
      if (bufferFiltered.length) {
        // Pobranie danych z tablicy
        dataJson = JSON.parse(bufferFiltered[0].value);
      } else {
        // Pobranie danych z bramki i zapisanie ich w tablicy
        dataJson = await this.getCouriersFunction(this.productParamsFunction());
        this.couriersDataBuffer.push({
          key: productParamsMD5,
          value: JSON.stringify(dataJson),
        });
      }
      if (dataJson && dataJson.data && dataJson.data.shipping && dataJson.data.shipping.shipping) {
        const { shipping } = dataJson.data.shipping;
        const dvpCouriers = shipping.filter((item) => item.prepaid === 'dvp');
        const prepaidCouriers = shipping.filter((item) => item.prepaid === 'prepaid');
        const shippingInfoElement = document.createElement('div');
        shippingInfoElement.classList.add('shipping_info');
        shippingInfoElement.id = 'shipping_info';
        shippingInfoElement.innerHTML = `<div class="shipping_info__body">
          ${(prepaidCouriers.length) ? `<div class="shipping_info__block --prepaid">
            <strong class="shipping_info__label">${app_shop.txt.shippingInfoPrepaid}</strong>
            <div class="shipping_info__header">
              <span class="shipping_info__header_item --icon-name">${app_shop.txt.shippingInfoHeaderName}</span>
              <span class="shipping_info__header_item --delivery">${app_shop.txt.shippingInfoHeaderDelivery}</span>
              <span class="shipping_info__header_item --cost">${app_shop.txt.shippingInfoHeaderCost}</span>
            </div>
            <div class="shipping_info__couriers">
              ${prepaidCouriers.map((el) => that.getCourierHtml(el).outerHTML).join('')}
            </div>
          </div>` : ''}
          ${(dvpCouriers.length) ? `<div class="shipping_info__block --prepaid">
            <strong class="shipping_info__label">${app_shop.txt.shippingInfoDvp}</strong>
            <div class="shipping_info__header">
              <span class="shipping_info__header_item --icon-name">${app_shop.txt.shippingInfoHeaderName}</span>
              <span class="shipping_info__header_item --delivery">${app_shop.txt.shippingInfoHeaderDelivery}</span>
              <span class="shipping_info__header_item --cost">${app_shop.txt.shippingInfoHeaderCost}</span>
            </div>
            <div class="shipping_info__couriers">
              ${dvpCouriers.map((el) => that.getCourierHtml(el).outerHTML).join('')}
            </div>
          </div>` : ''}
        </div>
        <div class="shipping_info__footer">
          <span class="shipping_info__vat">${app_shop.txt.shippingInfoVat}</span>
        </div>`;
        if (this.onlyHtml) {
          // Odpalenie funkcji z przygotowanym HTML'em
          this.onlyHtml(shippingInfoElement);
        } else {
          // Odpalenie modalu
          Modal({
            element: shippingInfoElement,
            classList: '--shipping-info --large --mobile',
            afterShow: this.afterShowModal,
          });
        }
      } else {
        const messageHtml = `<div class="menu_messages_message"><div class="menu_messages_message_sub"><p>${app_shop.txt.txt_74629_7}</p></div></div>`;
        if (this.onlyHtml) {
          // Odpalenie funkcji z przygotowanym HTML'em
          this.onlyHtml(messageHtml);
        } else {
          // Odpalenie modalu
          Modal({
            html: messageHtml,
            classList: '--shipping-info',
            afterShow: this.afterShowModal,
          });
        }
      }
    };
  
    this.init = () => {
      const {
        getCouriersFunction,
        productParamsFunction,
        afterShowModal,
        onlyHtml,
      } = this.params;
      this.getCouriersFunction = getCouriersFunction || false;
      this.productParamsFunction = productParamsFunction || false;
      this.afterShowModal = afterShowModal || false;
      this.onlyHtml = onlyHtml || false;
      this.create();
    };
  };