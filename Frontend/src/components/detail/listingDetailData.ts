export type DetailGroup = {
  title: string
  items: Array<{
    label: string
    value: string
  }>
}

export const sharedListingDetail = {
  certification: 'Certified',
  roadPoints: '100 RoadPoints / day',
  overview:
    'The campervan has done 40,000 km. It is a 6-speed Comfortmatic manual and automatic drive with cab air con. The house has a 140-litre 3-way fridge/freezer, gas oven/grill, combi Truma water & heating system, 18.5" colour TV with auto aerial, two 120-watt solar panels, 1500-watt inverter with three new lithium house batteries total 300AH, towbar with bike rack and two electric bikes, 100-litre fresh water tank with two extra 10-litre water bottles, 115-litre wastewater tank, two 9 kg LPG gas bottles, two 20-litre toilet cassettes, 4m awning and ground sheet, outside table & chairs, coffee machine & grinder, and is fully furnished with bedding. Off-grid, the inverter charges the electric bikes and powers the coffee machine & grinder, vacuum cleaner, hairdryer & toaster.',
  owner: {
    displayName: 'suebirdnz',
    location: 'Christchurch, New Zealand',
    memberSince: '16/08/2023',
    spokenLanguages: 'English',
    about:
      'Friendly New Zealand-based owner sharing a well-equipped campervan for comfortable road trips and longer stays.',
  },
  notices: [
    'No pets allowed',
    'Non-smoking vehicle',
    'Owner approval is required before confirming a swap',
  ],
  detailGroups: [
    {
      title: 'Technical',
      items: [
        { label: 'Brand of the wearer', value: 'Fiat' },
        { label: 'Carrier Model', value: 'CI Riviera 82p' },
        { label: 'Year', value: '2019' },
        { label: "Manufacturer's brand", value: 'Ci' },
        { label: "Manufacturer's Model", value: 'Riviera 82p' },
        { label: 'Weight', value: '3,500 kg' },
        { label: 'Length', value: '7.4m (8m with bikes & rack)' },
        { label: 'Width', value: '2.31m' },
        { label: 'Height', value: '3m clearance' },
        { label: 'Fuel', value: 'Diesel' },
        { label: 'Tank capacity', value: '60 litre' },
        { label: 'Gear box', value: 'Automatic' },
        {
          label: 'Driving',
          value:
            'Driving air conditioning, driving heating, reversing camera, parking assistance, power steering, cruise control, GPS, central locking, hitch ball, wheel chocks, spare wheel',
        },
      ],
    },
    {
      title: 'Life on board',
      items: [
        { label: 'Number of single beds', value: '2' },
        { label: 'Number of double beds', value: '1' },
        { label: 'Type of bedding', value: 'Twin beds' },
        {
          label: 'Kitchen / Meals',
          value:
            'Cooking plate, sink, oven, extractor hood, fridge, freezer, crockery set, coffee maker, cookware, interior table, stove',
        },
        { label: 'Toilet', value: 'Indoor shower, outdoor shower, built-in toilets, washbasin, chemical toilet' },
        {
          label: 'Living equipment',
          value: 'Car radio, CD/MP3 player, television, cleaning kit, living space heating, bed linen, USB socket',
        },
        { label: "Owner's conditions", value: 'No pets allowed, non-smoking vehicle' },
      ],
    },
    {
      title: 'Autonomy',
      items: [
        { label: 'Autonomy', value: 'Solar panel, gas bottle, converter 12V/230V' },
        { label: 'Clear water', value: '22 Imperial gals' },
        { label: 'Wastewater', value: '25.3 Imperial gals' },
        { label: 'Black water', value: '8.80 Imperial gals' },
      ],
    },
    {
      title: 'Equipment',
      items: [
        { label: 'Outdoor', value: 'Lateral awning, outdoor table, trailer hitch, chairs' },
      ],
    },
  ] satisfies DetailGroup[],
}
