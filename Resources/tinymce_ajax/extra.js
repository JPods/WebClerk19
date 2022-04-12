(function(window) {

	/*************************************************************/
	/****************** REUSABLE CUSTOM FUNCTIONS ****************/
	/*************************************************************/

	window.ajax = function( params ) {

		var method = 'method' in params ? params['method'] : 'get';
		var queryURL = 'queryURL' in params ? params['queryURL'] : '';
		var data = 'data' in params ? params['data'] : '';
		var successCallback = 'success' in params ? params['success'] : function(params){console.log('Successfully completed AJAX request.')};
		var errorCallback = 'error' in params ? params['error'] : function(params){console.log('Error during AJAX request.');};
		var ajaxRequest = new XMLHttpRequest();

		ajaxRequest.onreadystatechange = function () {
			if ( ajaxRequest.readyState === 4 ) {
				if ( ajaxRequest.status === 200 ) {
					successCallback(ajaxRequest.responseText, ajaxRequest.status);
				} else {
					errorCallback(ajaxRequest.responseText, ajaxRequest.status);
				}
			}
		};

		if ( method.toLowerCase() == 'post' ) {

			ajaxRequest.open(method, queryURL, true);

			ajaxRequest.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

			ajaxRequest.send( data );

		} else {

			ajaxRequest.open(method, queryURL + ( data == '' ? '' : '?' + data ), true);

			ajaxRequest.send( null );

		}

	};

	/*************************************************************/
	/******************** PROTOTYPE EXTENSIONS *******************/
	/*************************************************************/

	HTMLFormElement.prototype.serialize = function() {

		var data = [];

		for ( var i = this.elements.length - 1; i >= 0; i-- ) {
			if ( this.elements[i].name === '' ) {
				continue;
			}
			switch ( this.elements[i].nodeName ) {
				case 'INPUT':
					switch ( this.elements[i].type ) {
						case 'file':
						case 'submit':
						case 'button':
							break;
						case 'checkbox':
						case 'radio':
							if ( this.elements[i].checked ) {
								data.push(this.elements[i].name + '=' + encodeURIComponent(this.elements[i].value));
							}
							break; 
						case 'email':
							if ( this.elements[i].checked ) {
								data.push(this.elements[i].name + '=' + this.elements[i].value);
							}
							break; 
						default:
							data.push(this.elements[i].name + '=' + encodeURIComponent(this.elements[i].value));
							break;
					}
					break;
				case 'TEXTAREA':
					data.push(this.elements[i].name + '=' + encodeURIComponent(this.elements[i].value));
					break;
				case 'SELECT':
					switch ( this.elements[i].type ) {
						case 'select-one':
							data.push(this.elements[i].name + '=' + encodeURIComponent(this.elements[i].value));
							break;
						case 'select-multiple':
							for ( var j = this.elements[i].options.length - 1; j >= 0; j-- ) {
								if ( this.elements[i].options[j].selected ) {
									data.push(this.elements[i].name + '=' + encodeURIComponent(this.elements[i].options[j].value));
								}
							}
							break;
					}
					break;
			}
		}

		return data.join('&');

	};

	/*************************************************************/
	/*************************** STATICS *************************/
	/*************************************************************/

}(window));