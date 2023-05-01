library(RNHANES)
library(sqldf)
library(plyr)
library(dplyr)
library(haven)
library(mice)
library(ggplot2)

# DEMO 

DEMO <- nhanes_load_data("DEMO", c("2009-2010", "2011-2012", "2013-2014"))

DEMO_2015 <-read_xpt("DEMO_I.XPT")
DEMO_2017 <-read_xpt("DEMO_J.XPT")

# Combine DEMO data from all years into one dataframe
DEMO_all <- bind_rows(DEMO$DEMO_G, DEMO$DEMO_H, DEMO$DEMO_I, DEMO_2015, DEMO_2017)

# Select important attributes: SEQN, Age, Gender, Race/Ethnicity
DEMO_subset <- DEMO_all %>%
  dplyr::select(SEQN, RIDAGEYR, RIAGENDR, RIDRETH1)
names(DEMO_subset) <- c("SEQN", "Age", "Gender", "Race")


# Diet supplement file

DIET <- nhanes_load_data("DR1TOT", c("2009-2010", "2011-2012", "2013-2014"))
DIET_2015 <- read_xpt("DR1TOT_I.XPT")
DIET_2017 <- read_xpt("DR1TOT_J.XPT")
# Load DIET data from all years into one dataframe
DIET_all <- bind_rows(DIET$DR1TOT, DIET_2015, DIET_2017)

DIET_subset <- DIET_all %>%
 dplyr:: select(SEQN, DR1TCHOL, DR1TATOC, DR1TATOA, DR1TVB6, DR1TFOLA, DR1TVB12, DR1TVC, DR1TMAGN, DR1TKCAL, DR1TSUGR)

names(DIET_subset) <- c("SEQN", "TotalCholesterolIntake", "AlphaTocopherolEquivalentIntake", "AlphaTocopherolIntake", 
                        "VitaminB6Intake", "TotalFolateIntake", "VitaminB12Intake", "VitaminCIntake", 
                        "MagnesiumIntake", "TotalEnergyIntake", "SugarIntake")


# Medication

MEDS_2009<- nhanes_load_data("RXQ_RX","2009-2010")

MEDS_2011 <- nhanes_load_data("RXQ_RX","2011-2012")

MEDS_2013 <- nhanes_load_data("RXQ_RX","2013-2014")

MEDS_2015 <- read_xpt("RXQ_RX_I.XPT")

MEDS_2017 <- read_xpt("RXQ_RX_J.XPT")

MED_all <- bind_rows(MEDS_2009,MEDS_2011,MEDS_2013,MEDS_2015,MEDS_2017)

MEDS_subset <- MED_all %>%
  dplyr::select(SEQN, RXDUSE, RXDDRUG, RXDDRGID, RXDDAYS, RXDCOUNT)

names(MEDS_subset) <- c("SEQN", "MedicationUse", "MedicationName", "MedicationID", "DaysSupply", "MedicationCount")

#Questionary dataset
QUEST <- nhanes_load_data("MCQ", c("2009-2010", "2011-2012", "2013-2014"))
QUEST_2015<- read_xpt("MCQ_I.XPT")
QUEST_2017 <- read_xpt("MCQ_J.XPT")

QUEST_all <- bind_rows(QUEST,QUEST_2015,QUEST_2017)
QUEST_subset <- QUEST_all %>%
 dplyr:: select(SEQN, MCQ160C, MCQ160D, MCQ160E, MCQ160F, MCQ160G, MCQ160K, MCQ160L)

names(QUEST_subset) <- c("SEQN", "EverHadHeartAttack", "EverHadAngina", "EverHadStroke", "EverHadHeartFailure", 
                         "EverHadCVD", "EverHadAtrialFibrillation", "EverHadCongenitalHeartDefect")

# Examination dataset (Blood pressure)

Exam_2009<- nhanes_load_data("BPX", "2009-2010")
Exam_2011 <-nhanes_load_data("BPX","2011-2012")
Exam_2013 <-nhanes_load_data("BPX","2013-2014")
Exam_2015 <- read_xpt("BPX_I.XPT")
Exam_2017 <- read_xpt("BPX_J (1).XPT")

Exam_all <- bind_rows(
  Exam_2009,
  Exam_2011,
  Exam_2013,
  Exam_2015,
  Exam_2017
)
Exam_subset <- Exam_all %>%
 dplyr:: select(SEQN, BPXSY1, BPXDI1, BPXSY2, BPXDI2, BPXSY3, BPXDI3, BPXSY4, BPXDI4, BPXML1)

names(Exam_subset) <- c("SEQN", "SystolicBP1", "DiastolicBP1", "SystolicBP2", "DiastolicBP2", "SystolicBP3", "DiastolicBP3", "SystolicBP4", "DiastolicBP4", "MeanArterialPressure")



# Environmental factors

ENV <- nhanes_load_data("PBCD" ,c("2009-2010", "2011-2012", "2013-2014"))
ENV_2015 <- read_xpt("PBCD_I.XPT")
ENV_2017 <- read_xpt("PBCD_J.XPT")



ENV_all <- bind_rows(ENV,ENV_2015,ENV_2017)


ENV_subset <- ENV_all %>%
  dplyr::select(SEQN, LBXBPB, LBXBCD, LBXTHG, LBXBSE, LBXBMN)

# Rename the columns
colnames(ENV_subset) <- c("SEQN", "Blood_lead", "Blood_cadmium", "Blood_mercury_total", "Blood_selenium", "Blood_manganese")


# Examination( Blood presure)

EXAM <- nhanes_load_data("BPX", years)
Exam_2015 <- read_xpt("BPX_I.XPT")
Exam_2017 <- read_xpt("BPX_J.XPT")
Exam_all <- bind_rows(EXAM, Exam_2015, Exam_2017)

# Select only the columns you need
Exam_subset  <- Exam_all %>% 
  dplyr::select(SEQN, BPXSY1, BPXSY2, BPXDI1, BPXDI2)

# Rename the columns
names(Exam_subset) <- c("SEQN", "Systolic1", "Systolic2", "Diastolic1", "Diastolic2")


# Load data for the specified years 
years <- c("2009-2010", "2011-2012", "2013-2014")


# Smoking dataset (SMQ)
SMQ <- nhanes_load_data("SMQ", years)
SMQ_2015 <- read_xpt("SMQ_I.XPT")
SMQ_2017 <- read_xpt("SMQ_J.XPT")
SMQ_all <- bind_rows(SMQ,SMQ_2015,SMQ_2017)
SMQ_subset <- SMQ_all %>%
  dplyr::select(SEQN, SMD030)

names(SMQ_subset) <- c("SEQN", "SmokingStatus")

# Physical activity dataset (PAQ)
PAQ <- nhanes_load_data("PAQ", years)
PAQ_2015 <- read_xpt("PAQ_I.XPT")
PAQ_2017 <- read_xpt("PAQ_J.XPT")
PAQ_all <- bind_rows(PAQ,PAQ_2015,PAQ_2017)

PAQ_subset <- PAQ_all %>%
  dplyr::select(SEQN, PAQ605, PAQ610) %>%
  dplyr::rename(SEQN = SEQN, Vigorous_Work_Activity = PAQ605, Hours_Per_Week = PAQ610)


# Body measurements dataset (WHQ)
WHQ <- nhanes_load_data("WHQ", years)
WHQ_2015 <- read_xpt("WHQ_I.XPT")
WHQ_2017 <- read_xpt("WHQ_J.XPT")
WHQ_all <- bind_rows(WHQ,WHQ_2015,WHQ_2017)
WHQ_subset <- WHQ_all %>%
  dplyr::select(SEQN, WHQ030, WHQ070)
names(WHQ_subset) <- c("SEQN", "Weight", "Height")

# Blood lipid dataset (TCHOL)
TCHOL <- nhanes_load_data("TCHOL", years)
TCHOL_2015 <- read_xpt("TCHOL_I.XPT")
TCHOL_2017 <- read_xpt("TCHOL_J.XPT")
TCHOL_all <- bind_rows(TCHOL,TCHOL_2015,TCHOL_2017)
TCHOL_subset <- TCHOL_all %>%
  dplyr::select(SEQN, LBXTC)
names(TCHOL_subset) <- c("SEQN", "TotalCholesterol")

# Blood glucose dataset (GLU)
GLU <- nhanes_load_data("GLU", years)
GLU_2015 <- read_xpt("GLU_I.XPT")
GLU_2017 <- read_xpt("GLU_J.XPT")
GLU_all <- bind_rows(GLU,GLU_2015,GLU_2017)
GLU_subset <- GLU_all %>%
  dplyr::select(SEQN, LBXGLU)
names(GLU_subset) <- c("SEQN", "FastingPlasmaGlucose")

# Alcohol consumption dataset (ALQ)
ALQ <- nhanes_load_data("ALQ", years)
ALQ_2015 <- read_xpt("ALQ_I.XPT")
ALQ_2017 <- read_xpt("ALQ_J.XPT")
ALQ_all <- bind_rows(ALQ,ALQ_2015,ALQ_2017)
ALQ_subset <- ALQ_all %>%
  dplyr::select(SEQN, ALQ101, ALQ120Q)

names(ALQ_subset) <- c("SEQN", "AlcoholicBeveragesConsumed", "AlcoholIntake")



# Merge all the datasets using SEQN
NHANES_data_update<- DEMO_subset %>%
  full_join(DIET_subset, by = "SEQN") %>%
  full_join(MEDS_subset, by = "SEQN") %>%
  full_join(QUEST_subset, by = "SEQN") %>%
  full_join(Exam_subset, by = "SEQN") %>%
  full_join(ENV_subset, by = "SEQN") %>%
  full_join(SMQ_subset, by = "SEQN") %>%
  full_join(PAQ_subset, by = "SEQN") %>%
  full_join(WHQ_subset, by = "SEQN") %>%
  full_join(TCHOL_subset, by = "SEQN") %>%
  full_join(GLU_subset, by = "SEQN") %>%
  full_join(ALQ_subset, by = "SEQN")

colnames(NHANES_data)
saveRDS(NHANES_data,"NHANES_data_update.rds")


Nhanes_data_update <- readRDS("NHANES_data.rds")
#Imputation using the mice() function. You can specify the number of imputations you want to generate using the m parameter. In this example, I'm using 5 imputations.
imputed_data <- mice(NHANES_data_update, m=5, maxit=50, method='pmm', seed=500)
# Access the first imputed dataset
imputed_dataset_1 <- complete(imputed_data, 1)

# View the first imputed dataset
View(imputed_dataset_1)
View(NHANES_data_update)
saveRDS(imputed_data,"imputed_dataset_1.rds")

# Count NA values in each column
na_counts <- colSums(is.na(imputed_dataset_1))

# Assuming you have already loaded the imputed dataset as 'imputed_dataset_1'

write.csv(imputed_dataset_1, file = "imputed_dataset_1.csv", row.names = FALSE)
head(imputed_dataset_1)




