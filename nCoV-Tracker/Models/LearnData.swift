//
//  LearnData.swift
//  nCoV-Tracker
//
//  Created by Marton Zeisler on 2020. 02. 17..
//  Copyright © 2020. Marton Zeisler. All rights reserved.
//

import UIKit

struct LearnData {
    
    static let aboutArticle = """
Coronaviruses (CoV) are a large family of viruses that cause illness ranging from the common cold to more severe diseases such as Middle East Respiratory Syndrome (MERS-CoV) and Severe Acute Respiratory Syndrome (SARS-CoV). A novel coronavirus (nCoV) is a new strain that has not been previously identified in humans.

Coronaviruses are zoonotic, meaning they are transmitted between animals and people.  Detailed investigations found that SARS-CoV was transmitted from civet cats to humans and MERS-CoV from dromedary camels to humans. Several known coronaviruses are circulating in animals that have not yet infected humans.

Common signs of infection include respiratory symptoms, fever, cough, shortness of breath and breathing difficulties. In more severe cases, infection can cause pneumonia, severe acute respiratory syndrome, kidney failure and even death.

Standard recommendations to prevent infection spread include regular hand washing, covering mouth and nose when coughing and sneezing, thoroughly cooking meat and eggs. Avoid close contact with anyone showing symptoms of respiratory illness such as coughing and sneezing.
"""
    
    static let protectCellDescription = """
Wash your hands frequently with soap and water or use an alcohol-based hand rub if your hands are not visibly dirty. Washing your hands with soap and water or using alcohol-based hand rub eliminates the virus if it is on your hands. When coughing and sneezing, cover mouth and nose with flexed elbow or tissue – discard tissue immediately into a closed bin and clean your hands with alcohol-based hand rub or soap and water.
"""
    
    static let questionsCellDescription = "Read common questions asked about coronavirus and find out all the answers. Learn more about how the virus spreads, how long the incubation period is and the dangers associated with this virus"
    
    static let mythCellDescription = """
Are hand dryers effective in killing the new coronavirus? No. Hand dryers are not effective in killing the 2019-nCoV. To protect yourself against the new coronavirus, you should frequently clean your hands with an alcohol-based hand rub or wash them with soap and water. Once your hands are cleaned, you should dry them thoroughly by using paper towels or a warm air dryer.
"""
    
    static var protectData = [
        ArticleData(title: "Wash your hands frequently", description: """
Wash your hands frequently with soap and water or use an alcohol-based hand rub if your hands are not visibly dirty.

Washing your hands with soap and water or using alcohol-based hand rub eliminates the virus if it is on your hands.
"""),
        ArticleData(title: "Practice respiratory hygiene", description: """
When coughing and sneezing, cover mouth and nose with flexed elbow or tissue – discard tissue immediately into a closed bin and clean your hands with alcohol-based hand rub or soap and water.

Covering your mouth and nose when coughing and sneezing prevent the spread of germs and viruses. If you sneeze or cough into your hands, you may contaminate objects or people that you touch.
"""),
        
        ArticleData(title: "Maintain social distancing", description: """
Maintain at least 1 metre (3 feet) distance between yourself and other people, particularly those who are coughing, sneezing and have a fever.

When someone who is infected with a respiratory disease, like 2019-nCoV, coughs or sneezes they project small droplets containing the virus. If you are too close, you can breathe in the virus.
"""),
        
        ArticleData(title: "Avoid touching eyes, nose and mouth", description: """
Hands touch many surfaces which can be contaminated with the virus. If you touch your eyes, nose or mouth with your contaminated hands, you can transfer the virus from the surface to yourself.
"""),
        
        ArticleData(title: "If you have fever, cough and difficulty breathing, seek medical care early", description: """
Tell your health care provider if you have traveled in an area in China where 2019-nCoV has been reported, or if you have been in close contact with someone with who has traveled from China and has respiratory symptoms.

Whenever you have fever, cough and difficulty breathing it’s important to seek medical attention promptly as this may be due to a respiratory infection or other serious condition. Respiratory symptoms with fever can have a range of causes, and depending on your personal travel history and circumstances, 2019-nCoV could be one of them.
"""),
        
        ArticleData(title: "If you have mild respiratory symptoms and no travel history to or within China", description: """
If you have mild respiratory symptoms and no travel history to or within China, carefully practice basic respiratory and hand hygiene and stay home until you are recovered, if possible.
"""),
        
        ArticleData(title: "As a general precaution, practice general hygiene measures when visiting live animal markets, wet markets or animal product markets", description: """
Ensure regular hand washing with soap and potable water after touching animals and animal products; avoid touching eyes, nose or mouth with hands; and avoid contact with sick animals or spoiled animal products. Strictly avoid any contact with other animals in the market (e.g., stray cats and dogs, rodents, birds, bats). Avoid contact with potentially contaminated animal waste or fluids on the soil or structures of shops and market facilities.
"""),
            
        ArticleData(title: "Avoid consumption of raw or undercooked animal products", description: """
Handle raw meat, milk or animal organs with care, to avoid cross-contamination with uncooked foods, as per good food safety practices.
""")
    ]
    
    static var questionsData = [
        ArticleData(title: "What is a coronavirus?", description: """
Coronaviruses are a large family of viruses found in both animals and humans. Some infect people and are known to cause illness ranging from the common cold to more severe diseases such as Middle East Respiratory Syndrome (MERS) and Severe Acute Respiratory Syndrome (SARS).
"""),
        
        ArticleData(title: "What is a \"novel\" coronavirus?", description: """
A novel coronavirus (CoV) is a new strain of coronavirus that has not been previously identified in humans.  The new, or “novel” coronavirus, now called 2019-nCoV, had not previously detected before the outbreak was reported in Wuhan, China in December 2019.
"""),
        
        ArticleData(title: "How dangerous is it?", description: """
As with other respiratory illnesses, infection with 2019-nCoV can cause mild symptoms including a runny nose, sore throat, cough, and fever.  It can be more severe for some persons and can lead to pneumonia or breathing difficulties.  More rarely, the disease can be fatal. Older people, and people with pre-existing medical conditions (such as, diabetes and heart disease) appear to be more vulnerable to becoming severely ill with the virus.
"""),
    
        ArticleData(title: "Can humans become infected with the 2019-nCoV from an animal source?", description: """
Detailed investigations found that SARS-CoV was transmitted from civet cats to humans in China in 2002 and MERS-CoV from dromedary camels to humans in Saudi Arabia in 2012. Several known coronaviruses are circulating in animals that have not yet infected humans.  As surveillance improves around the world, more coronaviruses are likely to be identified

The animal source of the 2019-nCoV has not yet been identified.  This does not mean you can catch 2019-nCoV from any animal or from your pet. It’s likely that an animal source from a live animal market in China was responsible for some of the first reported human infections. To protect yourself, when visiting live animal markets, avoid direct unprotected contact with live animals and surfaces in contact with animals.

The consumption of raw or undercooked animal products should be avoided. Raw meat, milk or animal organs should be handled with care, to avoid cross-contamination with uncooked foods, as per good food safety practices.
"""),
           
        ArticleData(title: "Can I catch 2019-nCoV from my pet?", description: """
No, at present there is no evidence that companion animals or pets such as cats and dogs have been infected or have spread 2019-nCoV.
"""),
        
        ArticleData(title: "Can the 2019-nCoV be transmitted from person to person?", description: """
Yes, the 2019-nCoV causes respiratory disease and can be transmitted from person to person, usually after close contact with an infected patient, for example, in a household workplace, or health care center.
"""),
        
        ArticleData(title: "Should I wear a mask to protect myself?", description: """
Wearing a medical mask can help limit the spread of some respiratory disease. However, using a mask alone is not guaranteed to stop infections and should be combined with other prevention measures including hand and respiratory hygiene and avoiding close contact – at least 1 metre (3 feet) distance between yourself and other people.

WHO advises on rational use of medical masks thus avoiding unnecessary wastage of precious resources and potential misuse of masks (see Advice on the use of masks). This means using masks only if you have respiratory symptoms (coughing or sneezing), have suspected 2019-nCoV infection with mild symptoms or are caring for someone with suspected 2019-nCoV infection. A suspected 2019-nCoV infection is linked to travel in an area in China where 2019-nCoV has been reported, or close contact with someone who has traveled from China and has respiratory symptoms.
"""),
        
        ArticleData(title: "How to put on, use, take of and dispose of a mask", description: """
1. Before putting on a mask, wash hands with alcohol-based hand rub or soap and water

2. Cover mouth and nose with mask and make sure there are no gaps between your face and the mask

3. Avoid touching the mask while using it; if you do, clean your hands with alcohol-based hand rub or soap and water

4. Replace the mask with a new one as soon as it is damp and do not re-use single-use masks

5. To remove the mask: remove it from behind (do not touch the front of mask); discard immediately in a closed bin; wash hands with alcohol-based hand rub or soap and water
"""),
        
        ArticleData(title: "Who can catch this virus?", description: """
People living or travelling in an area where the 2019-nCoV virus is circulating may be at risk of infection. At present, 2019-nCoV is circulating in China where the vast majority of people infected have been reported. Those infected from other countries are among people who have recently traveled from China or who have been living or working closely with those travellers, such as family members, co-workers or medical professionals caring for a patient before they knew the patient was infected with 2019-nCoV.
"""),
        
        ArticleData(title: "Who is at risk of developing severe illness?", description: """
While we still need to learn more about how 2019-nCoV affects people, thus far, older people, and people with pre-existing medical conditions (such as diabetes and heart disease) appear to be more at risk of developing severe disease.
"""),
        
        ArticleData(title: "How does the virus spread?", description: """
The new coronavirus is a respiratory virus which spreads primarily through contact with an infected person through respiratory droplets generated when a person, for example, coughs or sneezes, or through droplets of saliva or discharge from the nose. It is important that everyone practice good respiratory hygiene. For example, sneeze or cough into a flexed elbow, or use a tissue and discard it immediately into a closed bin.  It is also very important for people to wash their hands regularly with either alcohol-based hand rub or soap and water.
"""),
        
        ArticleData(title: "How long does the virus survive on surfaces?", description: """
It is still not known how long the 2019-nCoV virus survives on surfaces, although preliminary information suggests the virus may survive a few hours or more. Simple disinfectants can kill the virus making it no longer possible to infect people.
"""),
        
        ArticleData(title: "What's the difference between illness caused by 2019-nCoV, the flu or a cold?", description: """
People with 2019-nCoV infection, the flu, or a cold typically develop respiratory symptoms such as fever, cough and runny nose. Even though many symptoms are alike, they are caused by different viruses. Because of their similarities, it can be difficult to identify the disease based on symptoms alone. That’s why laboratory tests are required to confirm if someone has 2019-nCoV.
"""),
        
        ArticleData(title: "How long is the incubation period?", description: """
The incubation period is the time between infection and the onset of clinical symptoms of disease. Current estimates of the incubation period range from 1-12.5 days with median estimates of 5-6 days. These estimates will be refined as more data become available. Based on information from other coronavirus diseases, such as MERS and SARS, the incubation period of 2019-nCoV could be up to 14 days. WHO recommends that the follow-up of contacts of confirmed cases is 14 days.
"""),
        
        ArticleData(title: "Can 2019-nCoV be caught from a person who presents no symptoms?", description: """
Understanding the time when infected patients may spread the virus to others is critical for control efforts. Detailed medical information from people infected is needed to determine the infectious period of 2019-nCoV. According to recent reports, it may be possible that people infected with 2019-nCoV may be infectious before showing significant symptoms.  However, based on currently available data, the people who have symptoms are causing the majority of virus spread.
"""),
        
        ArticleData(title: "Is it safe to receive a package from China or any other place where the virus has been identified?", description: """
Yes, it is safe.  People receiving packages are not at risk of contracting the new coronavirus. From experience with other coronaviruses, we know that these types of viruses don’t survive long on objects, such as letters or packages.
"""),
        
        ArticleData(title: "Are antibiotics effective in preventing and treating the 2019-nCoV?", description: """
No, antibiotics do not work against viruses, they only work on bacterial infections. The novel coronavirus is a virus and, therefore, antibiotics should not be used as a means of prevention or treatment.
"""),
        
        ArticleData(title: "Are there any specific medicines to prevent or treat 2019-nCoV?", description: """
To date, there is no specific medicine recommended to prevent or treat the novel coronavirus. However, those infected with 2019-nCoV should receive appropriate care to relieve and treat symptoms, and those with severe illness should receive optimized supportive care. Some specific treatments are under investigation and will be tested through clinical trials.
"""),
        
        ArticleData(title: "Does the new coronavirus spread through aerosols?", description: """
Issues relating to aerosol often come up when people want to know how to protect themselves from respiratory diseases. When people sneeze or cough, they may spray big droplets but the droplets do not stay suspended in the air for long. They fall. Health care procedures like intubation can spray small droplets into the air. Bigger droplets fall quickly. Smaller ones fall less quickly.

We know about environmental contamination for MERS-CoV and finding RNA in air filtration systems (but not the live virus). However, for the new coronavirus, we still need to see the data and understand how transmission has been assessed.
""")
    ]
    
    static var mythData = [
        ArticleData(title: "Are hand dryers effective in killing the new coronavirus?", description: """
No. Hand dryers are not effective in killing the 2019-nCoV. To protect yourself against the new coronavirus, you should frequently clean your hands with an alcohol-based hand rub or wash them with soap and water. Once your hands are cleaned, you should dry them thoroughly by using paper towels or a warm air dryer.
"""),
        
        ArticleData(title: "Can an ultraviolet disinfection lamp kill the new coronavirus?", description: """
UV lamps should not be used to sterilize hands or other areas of skin as UV radiation can cause skin irritation.
"""),
        
        ArticleData(title: "How effective are thermal scanners in detecting people infected with the new coronavirus?", description: """
Thermal scanners are effective in detecting people who have developed a fever (i.e. have a higher than normal body temperature) because of infection with the new coronavirus.

However, they cannot detect people who are infected but are not yet sick with fever. This is because it takes between 2 and 10 days before people who are infected become sick and develop a fever.
"""),
        
        ArticleData(title: "Can spraying alcohol or chlorine all over your body kill the new coronavirus?", description: """
No. Spraying alcohol or chlorine all over your body will not kill viruses that have already entered your body. Spraying such substances can be harmful to clothes or mucous membranes (i.e. eyes, mouth). Be aware that both alcohol and chlorine can be useful to disinfect surfaces, but they need to be used under appropriate recommendations.
"""),
        
        ArticleData(title: "Is it safe to receive a letter or a package from China?", description: """
Yes, it is safe. People receiving packages from China are not at risk of contracting the new coronavirus. From previous analysis, we know coronaviruses do not survive long on objects, such as letters or packages.
"""),
        
        ArticleData(title: "Can pets at home spread the new coronavirus (2019-nCoV)?", description: """
At present, there is no evidence that companion animals/pets such as dogs or cats can be infected with the new coronavirus. However, it is always a good idea to wash your hands with soap and water after contact with pets. This protects you against various common bacteria such as E.coli and Salmonella that can pass between pets and humans.
"""),
        
        ArticleData(title: "Do vaccines against pneumonia protect you against the new coronavirus?", description: """
No. Vaccines against pneumonia, such as pneumococcal vaccine and Haemophilus influenza type B (Hib) vaccine, do not provide protection against the new coronavirus.

The virus is so new and different that it needs its own vaccine. Researchers are trying to develop a vaccine against 2019-nCoV, and WHO is supporting their efforts.

Although these vaccines are not effective against 2019-nCoV, vaccination against respiratory illnesses is highly recommended to protect your health.
"""),
        
        ArticleData(title: "Can regularly rinsing your nose with saline help prevent infection with the new coronavirus?", description: """
No. There is no evidence that regularly rinsing the nose with saline has protected people from infection with the new coronavirus.

There is some limited evidence that regularly rinsing nose with saline can help people recover more quickly from the common cold. However, regularly rinsing the nose has not been shown to prevent respiratory infections.
"""),
        
        ArticleData(title: "Can gargling mouthwash protect you from infection with the new coronavirus?", description: """
No. There is no evidence that using mouthwash will protect you from infection with the new coronavirus.

Some brands or mouthwash can eliminate certain microbes for a few minutes in the saliva in your mouth. However, this does not mean they protect you from 2019-nCoV infection.
"""),
        
        ArticleData(title: "Can eating garlic help prevent infection with the new coronavirus?", description: """
Garlic is a healthy food that may have some antimicrobial properties. However, there is no evidence from the current outbreak that eating garlic has protected people from the new coronavirus..
"""),
        
        ArticleData(title: "Does putting on sesame oil block the new coronavirus from entering the body?", description: """
No. Sesame oil does not kill the new coronavirus. There are some chemical disinfectants that can kill the 2019-nCoV on surfaces. These include bleach/chlorine-based disinfectants, either solvents, 75% ethanol, peracetic acid and chloroform.

However, they have little or no impact on the virus if you put them on the skin or under your nose. It can even be dangerous to put these chemicals on your skin.
"""),
        
        ArticleData(title: "Does the new coronavirus affect older people, or are younger people also susceptible?", description: """
People of all ages can be infected by the new coronavirus (2019-nCoV). Older people, and people with pre-existing medical conditions (such as asthma, diabetes, heart disease) appear to be more vulnerable to becoming severely ill with the virus.
"""),
        
        ArticleData(title: "Are antibiotics effective in preventing and treating the new coronavirus?", description: """
No, antibiotics do not work against viruses, only bacteria.

The new coronavirus (2019-nCoV) is a virus and, therefore, antibiotics should not be used as a means of prevention or treatment.

However, if you are hospitalized for the 2019-nCoV, you may receive antibiotics because bacterial co-infection is possible.
"""),
        
        ArticleData(title: "Are there any specific medicines to prevent or treat the new coronavirus?", description: """
To date, there is no specific medicine recommended to prevent or treat the new coronavirus (2019-nCoV).

However, those infected with the virus should receive appropriate care to relieve and treat symptoms, and those with severe illness should receive optimized supportive care. Some specific treatments are under investigation, and will be tested through clinical trials. WHO is helping to accelerate research and development efforts with a range or partners.
""") ]
    
}

struct ArticleData {
    var title: String
    var description: String
}


