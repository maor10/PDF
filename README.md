PDF
===
Introduction
===
This PDF API will allow you to create a PDF object, add images and text easily, and then create the PDF file, or attach it in an email.

We need donations to continue making APIs, so please donate!!

Thank you!

How to Create a PDF
===
First, before anything else, make sure you have added the two PDF files to your project.
Next, import PDF.h in whichever file you want to create the PDF. (#import "PDF.h")

To create a PDF :
=
PDF *pdf = [[PDF alloc]init]; [pdf initContent]; Note: You MUST do both of these to create a PDF

Set the size of the PDF to whatever you want:

[pdf setSize:CGSizeMake(600, 600)];

The header is AUTOMATICALLY added and will be put art a random place in the page, so to set the header position and size:

[pdf setHeaderRect:CGRectMake(x, y, width, height)]; Note: If you don't want a header, just set the position to something outside of the PDF.

Whether or not you want the header to be in the PDF or not, make SURE to set the header to something:

[pdf setHeader:@"A Header"]

To add an image to the PDF, simply do:

[pdf addImageWithRect:[UIImage imageNamed:@"appicon.jpg"] :CGRectMake(x,y,width,height)];

To add text to the PDF, simply do:

[pdf addTextWithRect:@"This is some text" :CGRectMake(x, y, width, height)]; Note: If the text length is longer then the width, the text will NOT appear.

Once you have added all the images and text you want, to create the PDF file, just do the following:

[pdf generatePdfWithFilePath:@"Name of file.pdf"]; Note: The object this method takes is the file path, but make sure to finish the name of the file you are making with .pdf

To attach this PDF to an email, simply do:

[vc addAttachmentData:pdf.data mimeType:@"application/pdf" fileName:@"Receipts.pdf"];
Note: "vc", in the above example is the MFMailComposeViewController Note: As seen above, to get the NSData of the pdf simple do pdf.data
An example of this Whole Process:
pdf = [[PDF alloc]init];

[pdf initContent];

[pdf setSize:CGSizeMake(600, 600)]; [pdf setHeader:@"I Header"];

[pdf setHeaderRect:CGRectMake(300, 100, 200, 50)];

[pdf addImageWithRect:[UIImage imageNamed:@"appicon.jpg"] :CGRectMake(210, 119, 131, 98)];

[pdf addTextWithRect:@"This is some text" :CGRectMake(169, 314, 240, 37)]; [self createDirect];

[pdf generatePdfWithFilePath:[self pathOfFile:@"Hello.pdf"]]; MFMailComposeViewController vc = [[MFMailComposeViewController alloc] init];

vc.mailComposeDelegate = self;

[vc setSubject:@"Receipts PDF"];

[pdf generatePdfWithFilePath:[self pathOfFile:@"pdf" :@"docs"]];

[vc addAttachmentData:pdf.data mimeType:@"application/pdf" fileName:@"Receipts.pdf"];

[self presentModalViewController:vc animated:YES];

Thank You, and Please Donate!