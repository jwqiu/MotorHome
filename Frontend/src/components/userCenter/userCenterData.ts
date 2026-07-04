import { listings, type Listing } from '../listing/listingData'

export type ReceivedEnquiryStatus = 'Pending' | 'Agreed' | 'Declined'

export type ReceivedEnquiry = {
  dateReceived: string
  id: number
  message: string
  senderEmail: string
  senderListing: Listing
  senderName: string
  status: ReceivedEnquiryStatus
  type: string
  yourListing: Listing
}

export const receivedEnquiries: ReceivedEnquiry[] = [
  {
    dateReceived: '09 Feb',
    id: 4,
    message: 'We are planning a family road trip and would love to discuss a direct exchange. Your motorhome looks like a strong fit for our travel dates, and our vehicle is available for the same period.',
    senderEmail: 'tom@example.com',
    senderListing: listings[8],
    senderName: 'Tom',
    status: 'Pending',
    type: 'Direct Exchange',
    yourListing: listings[1],
  },
  {
    dateReceived: '18 Apr',
    id: 5,
    message: 'Your Christchurch motorhome would work perfectly for our South Island plans. We can offer a well-equipped camper with flexible dates.',
    senderEmail: 'mia@example.com',
    senderListing: listings[4],
    senderName: 'Mia',
    status: 'Agreed',
    type: 'Direct Exchange',
    yourListing: listings[0],
  },
]

export function getReceivedStatusDescription(status: ReceivedEnquiryStatus) {
  switch (status) {
    case 'Pending':
      return 'Waiting for your response'
    case 'Agreed':
      return 'Contact details shared'
    case 'Declined':
      return 'You declined this request'
  }
}
