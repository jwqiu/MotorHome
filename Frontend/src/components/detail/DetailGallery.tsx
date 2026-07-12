import { useState } from 'react'

type DetailGalleryProps = {
  imageLabel: string
  photos: string[]
}

function DetailGallery({ imageLabel, photos }: DetailGalleryProps) {
  const [activePhoto, setActivePhoto] = useState(photos[0])

  return (
    <section aria-label="Listing photos">
      <div className="overflow-hidden rounded-4xl bg-white shadow-lg mt-6 sm:mt-0 shadow-blue-100">
        <div className="relative aspect-[16/10] bg-blue-50">
          <img
            alt={imageLabel}
            className="absolute inset-0 h-full w-full object-cover"
            src={activePhoto}
          />
        </div>
      </div>

      <div className="mt-5 grid grid-cols-3 gap-3 sm:grid-cols-5">
        {photos.map((photo, index) => (
          <button
            aria-label={`Show photo ${index + 1}`}
            className={`relative aspect-[4/3] cursor-pointer overflow-hidden rounded-2xl border bg-white transition ${
              activePhoto === photo
                ? 'border-blue-400 shadow-md shadow-blue-100'
                : 'border-white hover:border-blue-200'
            }`}
            key={`${photo}-${index}`}
            onClick={() => setActivePhoto(photo)}
            type="button"
          >
            <img alt="" className="absolute inset-0 h-full w-full object-cover" src={photo} />
          </button>
        ))}
      </div>
    </section>
  )
}

export default DetailGallery
