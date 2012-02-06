| This module provides data structures for HEP events, as outlined by the Les
  Houches Accord (hep-ph/0109068v1). It attempts to be as close as possible to
  a direct haskell translation of the accord. Other relevant documents include:

* L. Garren, I. G. Knowles, T. Sjostrand and T. Trippe, Eur. Phys. J. C
  15, 205 (2000).
  
* H. Plothow-Besch, Comput. Phys. Commun. 75, 396 (1993); CERN Program
  Library Long Writeup W5051 (2000); refer to
  <http://consult.cern.ch/writeup/pdflib/>.


> module Data.LHA where

| Describes a generated event.

> data Event = Event
>   { nPart     :: Int

^ The number of particles in this event.

>   , evProcId  :: Int

^ The ID of the subprocess used to generate this event.

>   , evWeight  :: Double
>   , scale     :: Double

^ The scale of the event, in GeV.

>   , aQED      :: Double
>   , aQCD      :: Double
>   , parts     :: [Particle]
>   }


| Describes the properties of an event generation run. Note that this data
  structure does not contain the generated event information.

> data Run = Run
>   { runBeam :: (Beam, Beam)

^ The properties of the two beams being used in this run.

>   , idwt    :: Int

^ Switch dictating how the event weights are to be interpreted.

>   , nProc   :: Int

^ The number of different subprocesses being used.

>   , procs   :: [Subprocess]

^ List of all subprocesses being used.

>   }


| Represents the properties of a single beam particle.

> data Beam = Beam
>   { beamPDG :: Int

^ ID of the beam particle according to the Particle Data Group convention.

>   , beamE   :: Double

^ Energy in GeV of the beam particle.

>   , pdfg    :: Int

^ Author group for the beam, according to the Cernlib PDFlib specification.

>   , pdfs    :: Int

^ PDF set ID for the beam, according to the Cernlib PDFlib specification.

>   }


| Describes the properties of a subprocess.

> data Subprocess = Subprocess
>   { procXSec  :: Double

^ The cross-section of this subprocess, in pb.

>   , procXErr  :: Double

^ The statistical error associated with the value of procXSec.

>   , procXMax  :: Double
>   , procId    :: Int
>   }


| Describes a single particle component of a generated event.

> data Particle = Particle
>   { partPDG   :: Int

^ ID of the particle according to the Particle Data Group convention.

>   , status    :: ParticleStatus

^ Status code of the particle.

>   , mothers   :: MaybePair Int

^ The mother particles.

>   , iColor    :: (Int, Int)
>   , partPx    :: Double
>   , partPy    :: Double
>   , partPz    :: Double
>   , partE     :: Double
>   , partM     :: Double
>   , lifetime  :: Double

^ The lifetime of the particle, in mm.

>   , spin      :: Double
>   }


| Status codes for particles.

> data ParticleStatus
>   = Incoming              -- ^ Corresponds to status code -1.
>   | OutgoingFinal         -- ^ Corresponds to status code +1.
>   | IntermediateSpaceLike -- ^ Corresponds to status code -2.
>   | IntermediateResonance -- ^ Corresponds to status code +2.
>   | DocumentationOnly     -- ^ Corresponds to status code +3.
>   | IncomingBeam          -- ^ Corresponds to status code -9.

> statusToInt Incoming = (-1)
> statusToInt OutgoingFinal = (1)
> statusToInt IntermediateSpaceLike = (-2)
> statusToInt IntermediateResonance = (2)
> statusToInt DocumentationOnly = (3)
> statusToInt IncomingBeam = (-9)

> statusFromInt (-1) = Incoming
> statusFromInt (1) = OutgoingFinal
> statusFromInt (-2) = IntermediateSpaceLike
> statusFromInt (2) = IntermediateResonance
> statusFromInt (3) = DocumentationOnly
> statusFromInt (-9) = IncomingBeam

> data MaybePair a = PZero | POne a | PBoth (a, a)

