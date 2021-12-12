import '../../widgets/copyright.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/app_controller.dart';
import '../../Constants/colors.dart';
import '../../widgets/custom_spacer.dart';
import '../../widgets/privacy_policy_widgets.dart';

class PrivacyPolicy extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  final MyAppController _app = Get.find();
  bool accept = false;
  String bullet = '\u2022';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [copyrightwidget()],
      backgroundColor: Color(0xff172b4d).withOpacity(0.5),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: primaryColor,
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Privacy Policy and Ts & Cs',
          style: TextStyle(
              fontFamily: 'Futura', fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20.0, top: 10, right: 20),
          child: Column(
            children: [
              privacyText(
                text: 'Ubran Network Ltd Privacy Notice',
                fontWeight: FontWeight.bold,
              ),
              privacyText(
                text: 'Welcome to Urbane Network Ltd Privacy Notice.',
                fontWeight: FontWeight.bold,
              ),
              privacyText(
                text:
                    'Urbane Network Ltd respects your privacy and is committed to protecting your personal data. This Privacy Notice informs you about how we use and look after your personal data, including any data you may provide through this App/Website, or when you request information about other products or services from Urbane Network Ltd or otherwise communicate with us, when we provide our products and services to you and when information and personal data is provided to us relating to our business. This Notice also informs you about your privacy rights and how the law protects you. ',
              ),
              privacyText(
                text:
                    'This Notice applies to any individual whose personal information we hold or use, whether you are a current or prospective customer or supplier or anyone else. Employees of Urbane Network Ltd should however refer to the Urbane Network Ltd Staff Privacy Notice which contains specific information for them. ',
              ),
              privacyText(
                text:
                    'You can click through to the specific areas listed below. Alternatively, you can download a pdf version of the Notice here:',
              ),
              privacyLink(link: 'https://www.urbanet.co.uk/privacy'),
              privacyText(
                text: 'Who we are ',
                fontWeight: FontWeight.bold,
              ),
              privacyText(
                  text:
                      'Urbane Network Ltd PLC is the controller and responsible for your personal data (referred to as "Urbane Network Ltd", “giving made easy”, "we", "us" or "our" and all the names of individual apps operated by Urbane Network in this Privacy Notice). Urbane Network Ltd PLC is also responsible for this app and App/Website. '),
              privacyText(
                text:
                    'Our Data Protection Officer is responsible for overseeing questions in relation to this Privacy Notice. If you have any questions about this Privacy Notice, including any requests to exercise your legal rights (including any opt-out mentioned in this Privacy Notice), please contact the Data Protection Officer using the details set out below. ',
              ),
              privacyText(
                text: 'Contact details  ',
                fontWeight: FontWeight.bold,
              ),
              privacyText(
                text: 'Our full details are: ',
              ),
              privacyText(
                text:
                    'Name of legal entity: Urbane Network Ltd PLC (No. 10227717) registered in England and Wales at the companies house.',
              ),
              privacyText(
                text:
                    '\t\t$bullet Email address of the Data Protection Officer: office@urbanet.co.uk\n\t\t$bullet Postal address of XandWhy Building, 20-30 Whitechapel Road, London E1 1EW.\n\t\t$bullet Telephone number: 0203 984 6696 \n\t\t$bullet Email:office@urbanet.co.uk',
              ),
              privacyText(
                text:
                    'If you have a complaint relating to such data, please contact the Data Protection Officer by email, telephone or post at the above address. You have the right to make a complaint at any time to the Information Commissioner\'s Office (ICO), the UK supervisory authority for data protection issues (www.ico.org.uk). We would, however, prefer to deal with your concerns before you approach the ICO so please contact us in the first instance. ',
              ),
              privacyText(
                text:
                    'In this Privacy Notice, the terms “personal data”, “processing”, “data controller” and “data processor” shall have the meaning ascribed to them in the General Data Protection Regulation ((EU) 2016/679). ',
              ),
              privacyText(
                text: 'Contents',
                fontWeight: FontWeight.bold,
              ),
              privacyText(
                text:
                    '1. Personal data we collect\n2. How we use your personal data, and the legal basis for doing so \n3. Messages to you (including marketing) \n4. Disclosure of personal data \n5. External links and social media sites \n6. Where we store personal data \n7. Changes of Business Ownership and Control \n8. Security and data retention \n9. Your rights \n10. Changes to this Notice ',
                fontWeight: FontWeight.bold,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Divider(
                  height: 20,
                  color: Colors.white,
                ),
              ),
              privacyText(
                text: '1. Personal data we collect',
                fontWeight: FontWeight.bold,
              ),
              privacyText(
                text:
                    'We may obtain information from you directly (for example when you register to use the app). This will include the following:  ',
              ),
              privacyText(
                text:
                    '\t\t•	personal details (e.g. name, address, telephone number, amount donated, giftaid status or other identification information); \n\t\t•	contact details (e.g. phone number, email address, postal address or mobile number); \n\t\t•	transactional details (e.g. payments you make and to organisations made); \n\t\t•	financial information (payments you have made, dates, times, amounts, frequency); \n\t\t•	information about any other Urbane Network Ltd products and services you currently have, you have applied for, or you have previously held. ',
              ),
              privacyText(
                text:
                    'If you do not provide personal data that we request, it may mean that we are unable to provide you with the services and/or perform all of our obligations under our agreement with you. ',
              ),
              privacyText(
                text:
                    'We will also hold information we collect about you from other sources. This could include:  ',
              ),
              privacyText(
                text:
                    '\t\t•	the way you are using our App/Websites or mobile applications; \n\t\t•	your interactions with us, for example through our telephone services, App/Websites, mobile applications, social media or other channels; \n\t\t•	the way you use your app, including information about payments you make, including the details of the payee (for example, charity or other organisation); ',
              ),
              privacyText(
                text:
                    'We also collect personal data automatically when you use the App/Website and when you navigate through the App/Website. Data collected automatically may include usage details, geo-location data, IP addresses and other data collected through cookies and other tracking technologies. For more information on our use of these technologies, see our Cookie Notice ',
              ),
              privacyLink(link: 'https://www.urbanet.co.uk/cookies-policy'),
              privacyText(
                text:
                    'We may monitor or record phone calls with you in case we need to check we have carried out your instructions correctly, to resolve queries or issues, for regulatory purposes, to help improve our quality of service and to help detect or prevent fraud or other crimes. Conversations may also be monitored for staff training purposes. ',
              ),
              privacyText(
                text:
                    'If you give us personal data about other people then you confirm that they are aware of the information in this Notice about how we will use their personal data. This may happen if you supply us information about your dependents or joint account holders. ',
              ),
              privacyText(
                text:
                    '2. How we use your personal data, and the legal basis for doing so',
                fontWeight: FontWeight.bold,
              ),
              privacyText(
                text:
                    'We can only process your personal data on a basis permitted by law. The legal basis will usually one of the following:  ',
              ),
              privacyText(
                text:
                    '\t\t•	to allow us to take actions that are necessary in order to provide you with the product/service (to perform our contract with you); for example, to make payments; \n\t\t•	necessary to allow us to comply with our legal obligations; for example, obtaining proof of identity for anti-money laundering obligations. \n\t\t•	necessary for our or your legitimate interests; for example, to help us develop and improve our services. \n\t\t•	where we have your consent to do so; or \n\t\t•	in the case of special categories of personal data, that it is in the substantial public interest.',
              ),
              privacyText(
                text:
                    'We have set out below, in a table format, a description of all the ways we use the various types of personal information and which of the legal bases we rely on to do so. We have also identified what our legitimate interests are where appropriate. Note that we may process your personal data on more than one lawful basis depending on the specific purpose for which we are using your data. Where we are relying on a legitimate interest, these are also set out below: ',
              ),
              privacyText(
                text: '3. Messages to you (including marketing) ',
                fontWeight: FontWeight.bold,
              ),
              privacyText(
                text:
                    'We may send you messages (by telephone, post, text and email and other digital means) to help you manage your App account, to comply with regulatory obligations (such as contract changes) and to keep you informed about features of the products and services you use.  ',
              ),
              privacyText(
                text:
                    'We may also send you marketing messages, to inform you about products and services (including those of others) that may be of interest to you. You can ask us to stop or start sending you marketing messages at any time by contacting us (see Contact Us at the beginning of this Privacy Notice) or by following the unsubscribe instructions in our marketing messages. The messages sent to you may come us as the app owners and also from the charity or organisation that you have donating or donated to.',
              ),
              privacyText(
                text: 'Consent ',
                fontWeight: FontWeight.bold,
              ),
              privacyText(
                text:
                    'We may obtain consent to collect and use certain types of personal data when we are required to do so by law (for example, sometimes when we process sensitive personal data or when we place cookies or similar technologies on devices or browsers). If we ask for your consent to process your personal data, you may withdraw your consent at any time by following the unsubscribe instructions in our communications with you or by contacting us using the details set out in the Contact Us section at the beginning of this Privacy Notice or, if in relation to cookies or similar, via the cookie policy on',
              ),
              privacyLink(link: 'https://www.urbanet.co.uk/cookies-policy'),
              privacyText(
                text: '4. Disclosure of personal data ',
                fontWeight: FontWeight.bold,
              ),
              privacyText(
                text:
                    'We will treat all your personal information as private and confidential (even when you are no longer a customer). We will not reveal your name, address or any details of your relationship with us to anyone except those consented by use meaning us as Urbane Network Ltd, our apps and the organisations that you give or have given to, including.',
              ),
              privacyText(
                text:
                    '\t\t•	law enforcement bodies, Courts of law or as otherwise required or authorised by law; and \n\t\t•	regulators, trade associations or government bodies for the purposes of resolving complaints or disputes both internally and externally or to comply with any investigation by one of those bodies. ',
              ),
              privacyText(
                  text:
                      'We may also disclose personal data to third parties if we are under a duty to disclose or share personal data relating to you in order to comply with any legal obligation, or in order to enforce or apply our App/Website Terms of Use  '),
              privacyLink(
                  link:
                      'https:// www.urbanet.co.uk /useful-info- tools/legal/'),
              privacyText(
                text:
                    'and other agreements; or to protect the rights, property, or safety of us, our clients, or others. For example, we may be required by law or regulation to share information about your accounts with the UK or relevant tax authorities, either directly or via the local tax authority. The tax authority we share the information with could then share that information with other appropriate tax authorities.',
              ),
              privacyText(
                text:  
                    'Before we disclose pe  rsonal data to a third party, we take steps to ensure that the third party will protect personal data in accordance with applicable privacy laws and in a manner consistent with this Notice. Third parties are required to restrict their use of this personal data to the purpose for which the data was provided. ',
              ),  
              privacyText(  
                text:  
                    'Sometimes the third   party will be outside the EEA, in which case see section 7 for more information. ',
              ),  
              privacyText(  
                text: '5. External lin  ks and social media sites ',
                fontWeight: FontWeight.bold,
              ),
              privacyText(
                text:
                    'Although the App/Website only looks to include safe and relevant external links, users should always adopt a note of caution before clicking any external web links mentioned throughout the App/Website.  ',
              ),
              privacyText(
                text:
                    'If you follow a link to any of these App/Websites, please note that these App/Websites have their own privacy policies or notices and that we do not accept any responsibility or liability for these policies. Please check these policies or notices before you submit any personal data to these App/Websites. ',
              ),
              privacyText(
                text:
                    'Communication, engagement and actions taken through external social media platforms are subject to the terms and conditions as well as the privacy policies of those social media platforms ',
              ),
              privacyText(
                text:
                    'This App/Website may use social sharing buttons which help share web content directly from our web pages to the social media platform in question. Where you use such social sharing buttons you do so at your own discretion. You should note that the social media platform may ',
              ),
              privacyText(
                text:
                    'track and save your request to share a web page respectively through your social media platform account. Please note these social media platforms have their own privacy policies, and we do not accept any responsibility or liability for these policies. Please check these policies before you submit any personal data to these social media platforms.  ',
              ),
              privacyText(
                text: '6. Where we store personal data',
                fontWeight: FontWeight.bold,
              ),
              privacyText(
                text:
                    'If you live in the EU, the personal data relating to you that we collect may be transferred to, and stored at, locations outside the European Economic Area ("EEA"). It may also be processed by staff operating outside the EEA who work for us or for one of our service providers. ',
              ),
              privacyText(
                text:
                    'As described in this Privacy Notice, we may also share personal data relating to you with third parties who are located overseas, for business purposes and operational, support and continuity purposes, for example, when we use IT service providers or data storage services.  ',
              ),
              privacyText(
                text:
                    'Countries where personal data relating to you may be stored and/or processed, or where recipients of personal data relating to you may be located, may have data protection laws which differ to the data protection laws in your country of residence. By submitting your personal data, you accept that personal data relating to you may be transferred, stored or processed in this way. We take measures to ensure that any international transfer of information is managed carefully and in accordance with data protection law to protect your rights and interests and in accordance with this Notice. ',
              ),
              privacyText(
                text: 'These measures include: ',
              ),
              privacyText(
                text:
                    '\t\t•	Transfers of your personal data to countries which are recognised as providing an adequate level of legal protection for personal data; \n\t\t•	We have obtained the consent of data subjects to the international transfer of their personal data; \n\t\t•	Transfers within the Urbane Network Ltd Group where we have entered into Standard Contractual Clauses or an intra-group agreement, both of which give specific contractual protections designed to ensure that your personal data receives an adequate and consistent level of protection wherever it is transferred within the Group; \n\t\t•	Transfers to organisations where we are satisfied about their data privacy and security standards and protected by contractual commitments such as signing the Standard Contractual Clauses and, where available, further assurances such as certification schemes; and \n\t\t•	if transferred to the United States of America, the transfer will be to organizations that are part of the Privacy Shield. ',
              ),
              privacyText(
                text:
                    'You have the right to ask us for more information about our safeguards. Please contact the Data Protection Officer (see the Contact Us section at the beginning of this Privacy Notice). ',
              ),
              privacyText(
                text: '7. Changes of Business Ownership and Control ',
                fontWeight: FontWeight.bold,
              ),
              privacyText(
                text:
                    'It may be that this business may be sold to new owners or board of control changes, however any such change will comply with the policy herein',
              ),
              privacyText(
                text: '8. Security and data retention ',
                fontWeight: FontWeight.bold,
              ),
              privacyText(
                text:
                    'Unfortunately, the transmission of information and data via the internet is not completely secure. Although we will do our best to protect personal data relating to you, we cannot guarantee the security of such data transmitted to the App/Website; any transmission is at your own risk. Once we have received personal data relating to you, we use strict procedures and security features to try to prevent unauthorised access. ',
              ),
              privacyText(
                text:
                    'We may, from time to time, expand, reduce or sell our business, and this may involve the transfer of certain divisions or the whole business to other parties. Personal data relating to you will, where it is relevant to any division so transferred, be transferred along with that division and the new owner or newly controlling party will, under the terms of this Privacy Notice, be permitted to use personal data relating to you for the purposes for which it was supplied by you. ',
              ),
              privacyText(
                text:
                    'The security of personal data regarding you is a high priority. We take such steps as are reasonable securely to store personal data regarding you so that it is protected from unauthorised use or access, misuse, loss, modification or unauthorised disclosure. This includes both physical and electronic security measures. Examples include the use of passwords, locked storage cabinets and secured storage rooms. Other features include:  ',
              ),
              privacyText(
                text:
                    '\t\t•	storing information on secured networks consistent with industry standards, which are only accessible by those employees who have special access rights to such systems; \n\t\t•	using industry-standard encryption technologies when transferring or receiving personal data, such as SSL technology; \n\t\t•	restrictions are placed on the electronic transfer of files; \n\t\t•	our IT networks undergo regular necessary vulnerability testing to identify and remedy potential opportunities for unauthorised data access; and \n\t\t•	robust management of boundary firewalls, access controls, malware protection and patch release processes towards protecting customer data. ',
              ),
              privacyText(
                text: 'Retaining your data ',
                fontWeight: FontWeight.bold,
              ),
              privacyText(
                text:
                    'We will keep your personal data for as long as we have a relationship with you. Once our relationship with you has come to an end (e.g. following closure of your account or following a transaction), or your application for a product is declined or you decide not to go ahead with it, we will only retain your personal data for a period of time that is calculated depending on the type of personal data, and the purposes for which we hold that information. ',
              ),
              privacyText(
                text: 'We will only retain information that enables us to: ',
              ),
              privacyText(
                text:
                    '\t\t•	maintain business records for analysis and/or audit purposes; \n\t\t•	comply with record retention requirements under the law (for example, as required under legislation concerning the prevention, detection and investigation of money laundering and terrorist financing); \n\t\t•	defend or bring any existing or potential legal claims; \n\t\t•	maintain records of anyone who does not want to receive marketing from us; \n\t\t•	deal with any future complaints regarding the services we have delivered; \n\t\t•	assist with fraud monitoring; or \n\t\t•	assess the effectiveness of marketing that we may have sent you. ',
              ),
              privacyText(
                text:
                    'We have a retention policy which helps us ensure information is only held for the correct period. We then delete or de-identify your data. The retention period is generally linked to the amount of time available to bring a legal claim, which in many cases is six or seven years following closure of your account or following a transaction. We will retain your personal data after this time if we are required to do so to comply with the law, if there are outstanding claims or complaints that will reasonably require your personal data to be retained, or for regulatory or technical reasons. If we do, we will continue to make sure your privacy is protected. ',
              ),
              privacyText(
                text: '9. Your rights',
                fontWeight: FontWeight.bold,
              ),
              privacyText(
                text:
                    'You have certain rights regarding your personal data. These include the rights to: ',
              ),
              privacyText(
                text:
                    '\t\t• request a copy of the personal data we hold about you; \n\t\t•	request that we supply you (or a nominated third party) with an electronic copy of the personal data that you have provided us with; \n\t\t•	inform us of a correction to your personal data; \n\t\t•	exercise your right to restrict our use of your personal data; \n\t\t•	exercise your right to erase your personal data; or \n\t\t•	object to particular ways in which we are using your personal data (such as automated decision making, or profiling (for example to help us decide what products and services would suit you best); or \n\t\t•	understand the basis of international transfers of your data by us. ',
              ),
              privacyText(
                text:
                    'Where we rely on our legitimate interests to obtain and use your personal data then you have the right to object if you believe your fundamental rights and freedoms outweigh our legitimate interests. Where processing is carried out based upon your consent, you have the right to withdraw that consent. ',
              ),
              privacyText(
                text:
                    'Your ability to exercise these rights will depend on a number of factors and in some instances, we will not be able to comply with your request e.g. because we have legitimate grounds for not doing so or where the right does not apply to the particular data we hold on you. ',
              ),
              privacyText(
                text:
                    'You should note that if you exercise certain of these rights we may be unable to continue to provide some or all of our services to you (for example where the personal data is required by us to comply with a statutory requirement, or is necessary in order for us to perform our contract with you). ',
              ),
              privacyText(
                text:
                    'We ask that you contact us to update or correct your information if it changes or if the personal data we hold about you is inaccurate.  ',
              ),
              privacyText(
                text:
                    'Please contact the Data Protection Officer if you wish to exercise any of your rights',
              ),
              privacyText(
                text:
                    'If you have a concern about the way we are collecting or using personal data relating to you, we request that you raise your concern with us in the first instance. Alternatively, you can contact the Information Commissioner’s Office at   ',
              ),
              privacyLink(link: 'https://ico.org.uk/concerns/'),
              privacyText(
                text: '10. Changes to this Notice',
                fontWeight: FontWeight.bold,
              ),
              privacyText(
                text:
                    'We review and amend our Privacy Notice from time to time. Any changes we make to this Notice in the future will be posted on this page and, where appropriate, notified to you by e- mail. Please check back frequently to see any updates or changes to this Notice. The new terms may be displayed on-screen and you may be required to read and accept them to continue your use of the App/Website. ',
              ),
              privacyText(
                text: 'Last updated: 21 March 2021',
                fontWeight: FontWeight.bold,
              ),
              vspace(height: 20),
              if(!_app.privacyAccepted.value)
              Theme(
                data: ThemeData(
                  unselectedWidgetColor: primaryColor,
                ),
                child: Row(
                  children: [
                    Radio(
                        activeColor: primaryDark,
                        toggleable: true,
                        value: !false,
                        groupValue: accept,
                        onChanged: (val) {
                          setState(() {
                            accept = val;
                            print(accept);
                          });
                        }),
                    Text(
                      'Agree to Terms & Conditions',
                      style: TextStyle(
                        color: textColor,
                        fontFamily: 'Futura',
                      ),
                    )
                  ],
                ),
              ),
              if(!_app.privacyAccepted.value)
              Container(
                width: Get.width,
                height: 50,
                margin: EdgeInsets.only(top: 10),
                child: ElevatedButton(
                  onPressed: () {
                    if (accept == true) {
                      print('clicked');
                      _app.privacyAccepted.value = accept;
                      Get.back();
                    } else {
                      print('Need to accept the privacy policy to continue');
                    }
                  },
                  child: Text('ACCEPT'),
                ),
              ),
              vspace(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
