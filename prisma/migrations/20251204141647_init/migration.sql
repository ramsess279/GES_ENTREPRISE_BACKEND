-- CreateTable
CREATE TABLE "Entreprise" (
    "id" TEXT NOT NULL,
    "nom" TEXT NOT NULL,
    "adresse" TEXT,
    "latitude" DOUBLE PRECISION,
    "longitude" DOUBLE PRECISION,
    "email" TEXT NOT NULL,
    "telephone" TEXT,
    "logoUrl" TEXT,
    "devise" TEXT NOT NULL DEFAULT 'XOF',
    "typePeriode" TEXT NOT NULL DEFAULT 'mensuelle',
    "couleurPrimaire" TEXT,
    "couleurSecondaire" TEXT,
    "typographie" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Entreprise_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Utilisateur" (
    "id" TEXT NOT NULL,
    "entrepriseId" TEXT,
    "employeId" TEXT,
    "nomComplet" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "telephone" TEXT NOT NULL,
    "motDePasse" TEXT NOT NULL,
    "motDePasseTemporaire" TEXT,
    "role" TEXT NOT NULL,
    "statut" TEXT NOT NULL DEFAULT 'actif',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Utilisateur_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Employe" (
    "id" TEXT NOT NULL,
    "entrepriseId" TEXT NOT NULL,
    "nomComplet" TEXT NOT NULL,
    "poste" TEXT NOT NULL DEFAULT 'employe',
    "postePersonnalise" TEXT,
    "typeContrat" TEXT NOT NULL,
    "salaireBase" DOUBLE PRECISION NOT NULL,
    "nombreHeures" INTEGER,
    "nombreJours" INTEGER,
    "coordonneeBancaire" TEXT,
    "email" TEXT,
    "telephone" TEXT,
    "statut" TEXT NOT NULL DEFAULT 'actif',
    "dateEmbauche" TIMESTAMP(3),
    "dateFin" TIMESTAMP(3),
    "situationMatrimoniale" TEXT,
    "nationalite" TEXT,

    CONSTRAINT "Employe_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PayRun" (
    "id" TEXT NOT NULL,
    "entrepriseId" TEXT NOT NULL,
    "periode" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "statut" TEXT NOT NULL DEFAULT 'brouillon',
    "dateCreation" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "dateDebut" TIMESTAMP(3),
    "dateFin" TIMESTAMP(3),
    "heureDebut" TEXT,
    "heureFin" TEXT,

    CONSTRAINT "PayRun_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Payslip" (
    "id" TEXT NOT NULL,
    "payRunId" TEXT NOT NULL,
    "employeId" TEXT NOT NULL,
    "salaireBrut" DOUBLE PRECISION NOT NULL,
    "deductions" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "salaireNet" DOUBLE PRECISION NOT NULL,
    "statut" TEXT NOT NULL DEFAULT 'en_attente',
    "dateGen" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "nombreJour" INTEGER,
    "nombreHeure" INTEGER,

    CONSTRAINT "Payslip_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Paiement" (
    "id" TEXT NOT NULL,
    "payslipId" TEXT NOT NULL,
    "montant" DOUBLE PRECISION NOT NULL,
    "mode" TEXT NOT NULL,
    "datePaiement" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "recuUrl" TEXT,
    "statut" TEXT NOT NULL DEFAULT 'partiel',

    CONSTRAINT "Paiement_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PricingPlan" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "currency" TEXT NOT NULL DEFAULT 'XOF',
    "period" TEXT NOT NULL DEFAULT 'mois',
    "maxEmployees" INTEGER NOT NULL,
    "description" TEXT,
    "popular" BOOLEAN NOT NULL DEFAULT false,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PricingPlan_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PricingFeature" (
    "id" TEXT NOT NULL,
    "pricingPlanId" TEXT NOT NULL,
    "feature" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "PricingFeature_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DashboardStats" (
    "id" TEXT NOT NULL,
    "totalCompanies" INTEGER NOT NULL DEFAULT 0,
    "compliantCompanies" INTEGER NOT NULL DEFAULT 0,
    "totalRevenue" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "totalSalaryMass" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "DashboardStats_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FrequencyEvolution" (
    "id" TEXT NOT NULL,
    "month" TEXT NOT NULL,
    "frequency" INTEGER NOT NULL,
    "year" INTEGER NOT NULL DEFAULT 2024,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "FrequencyEvolution_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UpcomingPayment" (
    "id" TEXT NOT NULL,
    "companyName" TEXT NOT NULL,
    "amount" DOUBLE PRECISION NOT NULL,
    "dueDate" TIMESTAMP(3) NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'pending',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "UpcomingPayment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MarketingContent" (
    "id" TEXT NOT NULL,
    "section" TEXT NOT NULL,
    "title" TEXT,
    "subtitle" TEXT,
    "description" TEXT,
    "statValue" TEXT,
    "statLabel" TEXT,
    "benefitTitle" TEXT,
    "benefitDesc" TEXT,
    "order" INTEGER NOT NULL DEFAULT 0,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "MarketingContent_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "EntrepriseRequest" (
    "id" TEXT NOT NULL,
    "nomEntreprise" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "telephone" TEXT NOT NULL,
    "nomContact" TEXT NOT NULL,
    "emailUtilisateur" TEXT NOT NULL,
    "logo" TEXT,
    "status" TEXT NOT NULL DEFAULT 'pending',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "EntrepriseRequest_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Pointage" (
    "id" TEXT NOT NULL,
    "employeId" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "timestamp" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "location" JSONB,
    "method" TEXT NOT NULL,
    "deviceId" TEXT,
    "photoUrl" TEXT,
    "ipAddress" TEXT,
    "verified" BOOLEAN NOT NULL DEFAULT false,
    "notes" TEXT,

    CONSTRAINT "Pointage_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Presence" (
    "id" TEXT NOT NULL,
    "employeId" TEXT NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "heuresTravaillees" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "statut" TEXT NOT NULL DEFAULT 'present',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Presence_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_PointageToPresence" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "Entreprise_nom_key" ON "Entreprise"("nom");

-- CreateIndex
CREATE UNIQUE INDEX "Entreprise_email_key" ON "Entreprise"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Utilisateur_employeId_key" ON "Utilisateur"("employeId");

-- CreateIndex
CREATE UNIQUE INDEX "Utilisateur_email_key" ON "Utilisateur"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Presence_employeId_date_key" ON "Presence"("employeId", "date");

-- CreateIndex
CREATE UNIQUE INDEX "_PointageToPresence_AB_unique" ON "_PointageToPresence"("A", "B");

-- CreateIndex
CREATE INDEX "_PointageToPresence_B_index" ON "_PointageToPresence"("B");

-- AddForeignKey
ALTER TABLE "Utilisateur" ADD CONSTRAINT "Utilisateur_entrepriseId_fkey" FOREIGN KEY ("entrepriseId") REFERENCES "Entreprise"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Utilisateur" ADD CONSTRAINT "Utilisateur_employeId_fkey" FOREIGN KEY ("employeId") REFERENCES "Employe"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Employe" ADD CONSTRAINT "Employe_entrepriseId_fkey" FOREIGN KEY ("entrepriseId") REFERENCES "Entreprise"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PayRun" ADD CONSTRAINT "PayRun_entrepriseId_fkey" FOREIGN KEY ("entrepriseId") REFERENCES "Entreprise"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Payslip" ADD CONSTRAINT "Payslip_payRunId_fkey" FOREIGN KEY ("payRunId") REFERENCES "PayRun"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Payslip" ADD CONSTRAINT "Payslip_employeId_fkey" FOREIGN KEY ("employeId") REFERENCES "Employe"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Paiement" ADD CONSTRAINT "Paiement_payslipId_fkey" FOREIGN KEY ("payslipId") REFERENCES "Payslip"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PricingFeature" ADD CONSTRAINT "PricingFeature_pricingPlanId_fkey" FOREIGN KEY ("pricingPlanId") REFERENCES "PricingPlan"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Pointage" ADD CONSTRAINT "Pointage_employeId_fkey" FOREIGN KEY ("employeId") REFERENCES "Employe"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Presence" ADD CONSTRAINT "Presence_employeId_fkey" FOREIGN KEY ("employeId") REFERENCES "Employe"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_PointageToPresence" ADD CONSTRAINT "_PointageToPresence_A_fkey" FOREIGN KEY ("A") REFERENCES "Pointage"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_PointageToPresence" ADD CONSTRAINT "_PointageToPresence_B_fkey" FOREIGN KEY ("B") REFERENCES "Presence"("id") ON DELETE CASCADE ON UPDATE CASCADE;
