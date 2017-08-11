
/*! =========================================================
 *
 * Material Bootstrap Wizard - V1.0.1
 *
 * =========================================================
 *
 * Copyright 2016 Creative Tim (http://www.creative-tim.com/product/material-bootstrap-wizard)
 *
 *
 *                       _oo0oo_
 *                      o8888888o
 *                      88" . "88
 *                      (| -_- |)
 *                      0\  =  /0
 *                    ___/`---'\___
 *                  .' \|     |// '.
 *                 / \|||  :  |||// \
 *                / _||||| -:- |||||- \
 *               |   | \\  -  /// |   |
 *               | \_|  ''\---/''  |_/ |
 *               \  .-\__  '-'  ___/-. /
 *             ___'. .'  /--.--\  `. .'___
 *          ."" '<  `.___\_<|>_/___.' >' "".
 *         | | :  `- \`.;`\ _ /`;.`/ - ` : | |
 *         \  \ `_.   \_ __\ /__ _/   .-` /  /
 *     =====`-.____`.___ \_____/___.-`___.-'=====
 *                       `=---='
 *
 *     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 *
 *               Buddha Bless:  "No Bugs"
 *
 * ========================================================= */

// Material Bootstrap Wizard Functions
searchVisible = 0;
transparent = true;
var teste;
var re = /\S+@\S+\.\S+/;

$(document)
		.ready(
				function() {
					jQuery.validator.addMethod("email",
							function(value, element) {
								if (re.test(value)) {
									$.get("verificarEmail", {
										'email' : value
									}, function(retorno) {
										teste = retorno;
										if (teste) {
											$(element).parent('div')
													.removeClass('has-error');
										} else
											$(element).parent('div').addClass(
													'has-error');
									});
								} else
									$(element).parent('div').addClass(
											'has-error');
								return teste;
							});

					jQuery.validator
							.addMethod(
									"cpf",
									function(value, element) {
										value = jQuery.trim(value);

										value = value.replace('.', '');
										value = value.replace('.', '');
										cpf = value.replace('-', '');
										while (cpf.length < 11)
											cpf = "0" + cpf;
										var expReg = /^0+$|^1+$|^2+$|^3+$|^4+$|^5+$|^6+$|^7+$|^8+$|^9+$/;
										var a = [];
										var b = new Number;
										var c = 11;
										for (i = 0; i < 11; i++) {
											a[i] = cpf.charAt(i);
											if (i < 9)
												b += (a[i] * --c);
										}
										if ((x = b % 11) < 2) {
											a[9] = 0
										} else {
											a[9] = 11 - x
										}
										b = 0;
										c = 11;
										for (y = 0; y < 10; y++)
											b += (a[y] * c--);
										if ((x = b % 11) < 2) {
											a[10] = 0;
										} else {
											a[10] = 11 - x;
										}

										var retorno = true;
										if ((cpf.charAt(9) != a[9])
												|| (cpf.charAt(10) != a[10])
												|| cpf.match(expReg))
											retorno = false;

										return this.optional(element)
												|| retorno;

									}, "");

					jQuery.validator
							.addMethod(
									"cnpj",
									function(value, element) {

										value = jQuery.trim(value);
										
										value = value.replace('.', '');
										value = value.replace('.', '');
										value = value.replace('/', '');
										value = value.replace('-', '');
										cnpj = value;
										
										console.log(cnpj)
										
										var numeros, digitos, soma, resultado, pos, tamanho, digitos_iguais = true;

										if (cnpj.length < 14
												&& cnpj.length > 15)
											return false;

										for (var i = 0; i < cnpj.length - 1; i++)
											if (cnpj.charAt(i) != cnpj
													.charAt(i + 1)) {
												digitos_iguais = false;
												break;
											}

										if (!digitos_iguais) {
											tamanho = cnpj.length - 2
											numeros = cnpj
													.substring(0, tamanho);
											digitos = cnpj.substring(tamanho);
											soma = 0;
											pos = tamanho - 7;

											for (i = tamanho; i >= 1; i--) {
												soma += numeros.charAt(tamanho
														- i)
														* pos--;
												if (pos < 2)
													pos = 9;
											}

											resultado = soma % 11 < 2 ? 0
													: 11 - soma % 11;

											if (resultado != digitos.charAt(0))
												return false;

											tamanho = tamanho + 1;
											numeros = cnpj
													.substring(0, tamanho);
											soma = 0;
											pos = tamanho - 7;

											for (i = tamanho; i >= 1; i--) {
												soma += numeros.charAt(tamanho
														- i)
														* pos--;
												if (pos < 2)
													pos = 9;
											}

											resultado = soma % 11 < 2 ? 0
													: 11 - soma % 11;

											if (resultado != digitos.charAt(1))
												return false;

											return true;
										}

										return false;
									}, "");

					$('.cpf').mask('000.000.000-00', {
						reverse : true
					})

					$('.cnpj').mask('00.000.000/0000-00', {
						reverse : true
					});
					
					$('.celular').mask('(00) 00000-0000');

					$.material.init();

					/* Activate the tooltips */
					$('[rel="tooltip"]').tooltip();

					// Code for the Validator
					var $validator = $('.wizard-card form').validate({
						rules : {
							tipo : {
								required : true
							},
							nome : {
								required : true,
								minlength : 3
							},
							email : {
								email : true,
								required : true
							},
							senha : {
								required : true,
								minlength : 6
							},
							confirma_senha : {
								required : true,
								minlength : 6,
								equalTo : "#senha"
							},
							cpf : {
								cpf : true,
								required : true
							},
							cnpj : {
								cnpj : true,
								required : true
							},
							celular : {
								required : true,
							}
						},
						errorPlacement : function(error, element) {
							$(element).parent('div').addClass('has-error');
						}
					});

					// Wizard Initialization
					$('.wizard-card')
							.bootstrapWizard(
									{
										'tabClass' : 'nav nav-pills',
										'nextSelector' : '.btn-next',
										'previousSelector' : '.btn-previous',

										onNext : function(tab, navigation,
												index) {
											validaradio()
											var $valid = $('.wizard-card form')
													.valid();
											if (!$valid) {
												$validator.focusInvalid();
												return false;
											}
										},

										onInit : function(tab, navigation,
												index) {

											// check number of tabs and fill the
											// entire row
											var $total = navigation.find('li').length;
											$width = 100 / $total;
											var $wizard = navigation
													.closest('.wizard-card');

											$display_width = $(document)
													.width();

											if ($display_width < 600
													&& $total > 3) {
												$width = 50;
											}

											navigation.find('li').css('width',
													$width + '%');
											$first_li = navigation.find(
													'li:first-child a').html();
											$moving_div = $('<div class="moving-tab">'
													+ $first_li + '</div>');
											$('.wizard-card .wizard-navigation')
													.append($moving_div);
											refreshAnimation($wizard, index);
											$('.moving-tab').css('transition',
													'transform 0s');
										},

										onTabClick : function(tab, navigation,
												index) {
											var $valid = $('.wizard-card form')
													.valid();

											if (!$valid) {
												return false;
											} else {
												return true;
											}
										},

										onTabShow : function(tab, navigation,
												index) {
											var $total = navigation.find('li').length;
											var $current = index + 1;

											var $wizard = navigation
													.closest('.wizard-card');

											// If it's the last tab then hide
											// the last button
											// and show the finish instead
											if ($current >= $total) {
												$($wizard).find('.btn-next')
														.hide();
												$($wizard).find('.btn-finish')
														.show();
											} else {
												$($wizard).find('.btn-next')
														.show();
												$($wizard).find('.btn-finish')
														.hide().attr('type',
																'submit');
											}

											button_text = navigation.find(
													'li:nth-child(' + $current
															+ ') a').html();

											setTimeout(function() {
												$('.moving-tab').text(
														button_text);
											}, 150);

											var checkbox = $('.footer-checkbox');

											if (!index == 0) {
												$(checkbox).css({
													'opacity' : '0',
													'visibility' : 'hidden',
													'position' : 'absolute'
												});
											} else {
												$(checkbox).css({
													'opacity' : '1',
													'visibility' : 'visible'
												});
											}

											refreshAnimation($wizard, index);
										}
									});

					// Prepare the preview for profile picture
					$("#wizard-picture").change(function() {
						readURL(this);
					});

					$('[data-toggle="wizard-radio"]').click(
							function() {
								wizard = $(this).closest('.wizard-card');
								wizard.find('[data-toggle="wizard-radio"]')
										.removeClass('active');
								$(this).addClass('active');
								$(wizard).find('[type="radio"]').removeAttr(
										'checked');
								$(this).find('[type="radio"]').attr('checked',
										'true');
								$(this).find('[type="radio"]').prop('checked',
										'true');
							});

					$('[data-toggle="wizard-checkbox"]').click(
							function() {
								if ($(this).hasClass('active')) {
									$(this).removeClass('active');
									$(this).find('[type="checkbox"]')
											.removeAttr('checked');
								} else {
									$(this).addClass('active');
									$(this).find('[type="checkbox"]').attr(
											'checked', 'true');
								}
							});

					$('.set-full-height').css('height', 'auto');

				});

// Function to show image before upload

function readURL(input) {
	if (input.files && input.files[0]) {
		var reader = new FileReader();

		reader.onload = function(e) {
			$('#wizardPicturePreview').attr('src', e.target.result).fadeIn(
					'slow');
		}
		reader.readAsDataURL(input.files[0]);
	}
}

$(window).resize(function() {
	$('.wizard-card').each(function() {
		$wizard = $(this);
		index = $wizard.bootstrapWizard('currentIndex');
		refreshAnimation($wizard, index);

		$('.moving-tab').css({
			'transition' : 'transform 0s'
		});
	});
});

function refreshAnimation($wizard, index) {
	total_steps = $wizard.find('li').length;
	move_distance = $wizard.width() / total_steps;
	step_width = move_distance;
	move_distance *= index;

	$current = index + 1;

	if ($current == 1) {
		move_distance -= 8;
	} else if ($current == total_steps) {
		move_distance += 8;
	}

	$wizard.find('.moving-tab').css('width', step_width);
	$('.moving-tab').css({
		'transform' : 'translate3d(' + move_distance + 'px, 0, 0)',
		'transition' : 'all 0.5s cubic-bezier(0.29, 1.42, 0.79, 1)'

	});
}

materialDesign = {

	checkScrollForTransparentNavbar : debounce(function() {
		if ($(document).scrollTop() > 260) {
			if (transparent) {
				transparent = false;
				$('.navbar-color-on-scroll').removeClass('navbar-transparent');
			}
		} else {
			if (!transparent) {
				transparent = true;
				$('.navbar-color-on-scroll').addClass('navbar-transparent');
			}
		}
	}, 17)

}

function debounce(func, wait, immediate) {
	var timeout;
	return function() {
		var context = this, args = arguments;
		clearTimeout(timeout);
		timeout = setTimeout(function() {
			timeout = null;
			if (!immediate)
				func.apply(context, args);
		}, wait);
		if (immediate && !timeout)
			func.apply(context, args);
	};
};
