/// '/'
/// ['/login'],['/signup'],['/forgetPassword'], ['/homePage'] 
/// ['/ramadan'],['/hajj'], ['/jummah'], ['/privacyPolicy'] 
/// ['/Rthanks'],['/hthanks'], ['/thanksJummah'] : No parameters & Arguments required


/// '/forgetAlert': [arguments: email] 
/// '/otpScreen': [arguments: '+' + phoneNo.text,]
/// '/addCard' :  [arguments: backgroundColor] 
/// '/givingHistory': [arguments: color]

/// '/Uhome':  [arguments: loveJummahScaffold,] can be loveJummahScaffold & primaryColor
///   [parameters: { 'title' : '', 'app_mode':'', }] title will be "Love Jummah or Love Ramadan" & app_mode will be 'Jummah & Ramadan'
/// '/selectCard': [arguments: backgroundColor,] background color of screen
///   [parameters: {'m_name':name,'address': address,'stripeKey': stripeKey,'pay_type': 'Pay-One-Off',}] m_name : Name of mosque, address: Address of mosque, stripeKey: merchantId of mosques, pay_type: can be "Pay-One_Off" OR "Schedule"
/// '/pay' : [ arguments: backgroundColor,]
///   [parameters: {
///     'pay_type': parameters['pay_type'],
///     'name': name, // card holder name
///     'card_number': number, // card number
///     'expiry_date': expiry, // expiry date of card
///     'merchant_id': parameters['stripeKey'], // charity/mosque merchant/stripe id
///     'm_address': parameters['address'], // charity/mosque address
///     'mosque_name':parameters['m_name'], // charity/mosque name
///      'token' : token, // token for payment 
///   },]
/// '/hajjHome': [arguments: Colors.white,]
///   [ parameters: {'title': 'CHOOSE YOUR QURBANI','mode': 'qurbani',}] title : "ChOOSE YOUR QURBANI" or "CHOOSE YOUR SADQAH", mode: "qurbani" or "sadqah".
/// '/basket': [arguments: _background,]
///    [parameters: { 'm_name': name, 'm_addrss': address, 'stripeKey': stripeKey,'price': price,},] 
/// m_name: name of mosque/charity, m_address: address of mosque/charity, stripeKey: charity/mosque merchant id, price: price basket.